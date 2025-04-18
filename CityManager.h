
#import <Foundation/Foundation.h>

@interface CityManager : NSObject

@property (nonatomic, strong) NSDictionary *cityCodeMap;

+ (instancetype)sharedInstance;

- (NSString *)getProvinceNameWithCode:(NSString *)code;
- (NSString *)getCityNameWithCode:(NSString *)code;
- (NSString *)getDistrictNameWithCode:(NSString *)code;
- (NSString *)getStreetNameWithCode:(NSString *)code;

@end
