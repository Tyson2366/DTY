#import "CityManager.h"

@implementation CityManager {
    void (^_locationCallback)(NSString *, NSDictionary *);
}

+ (instancetype)sharedInstance {
    static CityManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
        [instance loadCityData];
    });
    return instance;
}

- (void)loadCityData {
    self.cityCodeMap = @{
        @"110101001": @{@"province": @"北京市", @"city": @"市辖区", @"district": @"东城区", @"street": @"东华门街道"},
        @"110101002": @{@"province": @"北京市", @"city": @"市辖区", @"district": @"东城区", @"street": @"景山街道"},
        @"110101003": @{@"province": @"北京市", @"city": @"市辖区", @"district": @"东城区", @"street": @"交道口街道"},
        @"310101001": @{@"province": @"上海市", @"city": @"市辖区", @"district": @"黄浦区", @"street": @"外滩街道"},
        @"310101002": @{@"province": @"上海市", @"city": @"市辖区", @"district": @"黄浦区", @"street": @"南京东路街道"},
    };
}

- (NSString *)getProvinceNameWithCode:(NSString *)code {
    return self.cityCodeMap[code][@"province"] ?: @"";
}

- (NSString *)getCityNameWithCode:(NSString *)code {
    return self.cityCodeMap[code][@"city"] ?: @"";
}

- (NSString *)getDistrictNameWithCode:(NSString *)code {
    return self.cityCodeMap[code][@"district"] ?: @"";
}

- (NSString *)getStreetNameWithCode:(NSString *)code {
    return self.cityCodeMap[code][@"street"] ?: @"";
}

- (void)startLocationWithCompletion:(void (^)(NSString *code, NSDictionary *info))completion {
    self->_locationCallback = completion;
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation *location = [locations lastObject];
    [self.locationManager stopUpdatingLocation];

    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        if (placemarks.count == 0) return;
        CLPlacemark *placemark = placemarks.firstObject;

        NSString *province = placemark.administrativeArea ?: @"";
        NSString *city = placemark.locality ?: placemark.subAdministrativeArea ?: @"";
        NSString *district = placemark.subLocality ?: @"";
        NSString *street = placemark.thoroughfare ?: @"";

        for (NSString *code in self.cityCodeMap) {
            NSDictionary *info = self.cityCodeMap[code];
            if ([info[@"province"] isEqualToString:province] &&
                [info[@"city"] isEqualToString:city] &&
                [info[@"district"] isEqualToString:district] &&
                [info[@"street"] isEqualToString:street]) {
                if (self->_locationCallback) {
                    self->_locationCallback(code, info);
                    self->_locationCallback = nil;
                }
                break;
            }
        }
    }];
}

@end
