
#import <Foundation/Foundation.h>

@interface CityManager : NSObject

@property (nonatomic, strong) NSDictionary *cityCodeMap;

+ (instancetype)sharedInstance;
- (NSString *)getCityNameWithCode:(NSString *)code;
- (NSString *)getProvinceNameWithCode:(NSString *)code;
- (NSString *)getDistrictNameWithCode:(NSString *)code;
- (NSString *)getStreetNameWithCode:(NSString *)code;
- (void)loadCityData;

@end
