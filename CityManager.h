#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface CityManager : NSObject <CLLocationManagerDelegate>

@property (nonatomic, strong) NSDictionary *cityCodeMap;
@property (nonatomic, strong) CLLocationManager *locationManager;

+ (instancetype)sharedInstance;

- (NSString *)getProvinceNameWithCode:(NSString *)code;
- (NSString *)getCityNameWithCode:(NSString *)code;
- (NSString *)getDistrictNameWithCode:(NSString *)code;
- (NSString *)getStreetNameWithCode:(NSString *)code;

- (void)startLocationWithCompletion:(void (^)(NSString *code, NSDictionary *info))completion;

@end
