#import "CityManager_Full.h"

@implementation CityManager

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
    self.cityCodeMap =
@{
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

@end