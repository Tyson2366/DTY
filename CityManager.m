#import "CityManager.h"

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
@"110101001": @{@"province": @"北京市", @"city": @"市辖区", @"district": @"东城区", @"street": @"东华门街道"},
@"110101002": @{@"province": @"北京市", @"city": @"市辖区", @"district": @"东城区", @"street": @"景山街道"},
@"110101003": @{@"province": @"北京市", @"city": @"市辖区", @"district": @"东城区", @"street": @"交道口街道"},
@"110101004": @{@"province": @"北京市", @"city": @"市辖区", @"district": @"东城区", @"street": @"安定门街道"},
@"110101005": @{@"province": @"北京市", @"city": @"市辖区", @"district": @"东城区", @"street": @"北新桥街道"},
@"110101006": @{@"province": @"北京市", @"city": @"市辖区", @"district": @"东城区", @"street": @"东四街道"},
@"110101007": @{@"province": @"北京市", @"city": @"市辖区", @"district": @"东城区", @"street": @"朝阳门街道"},
@"110101008": @{@"province": @"北京市", @"city": @"市辖区", @"district": @"东城区", @"street": @"建国门街道"},
@"110101009": @{@"province": @"北京市", @"city": @"市辖区", @"district": @"东城区", @"street": @"东直门街道"},
@"110101010": @{@"province": @"北京市", @"city": @"市辖区", @"district": @"东城区", @"street": @"和平里街道"},
@"110101011": @{@"province": @"北京市", @"city": @"市辖区", @"district": @"东城区", @"street": @"前门街道"},
@"110101012": @{@"province": @"北京市", @"city": @"市辖区", @"district": @"东城区", @"street": @"崇文门外街道"},
@"110101013": @{@"province": @"北京市", @"city": @"市辖区", @"district": @"东城区", @"street": @"东花市街道"},
@"110101014": @{@"province": @"北京市", @"city": @"市辖区", @"district": @"东城区", @"street": @"龙潭街道"},
@"110101015": @{@"province": @"北京市", @"city": @"市辖区", @"district": @"东城区", @"street": @"体育馆路街道"},
@"110101016": @{@"province": @"北京市", @"city": @"市辖区", @"district": @"东城区", @"street": @"天坛街道"},
@"110101017": @{@"province": @"北京市", @"city": @"市辖区", @"district": @"东城区", @"street": @"永定门外街道"},
@"110102001": @{@"province": @"北京市", @"city": @"市辖区", @"district": @"西城区", @"street": @"西长安街街道"},
@"110102003": @{@"province": @"北京市", @"city": @"市辖区", @"district": @"西城区", @"street": @"新街口街道"},
@"110102007": @{@"province": @"北京市", @"city": @"市辖区", @"district": @"西城区", @"street": @"月坛街道"},
@"110102009": @{@"province": @"北京市", @"city": @"市辖区", @"district": @"西城区", @"street": @"展览路街道"},
@"110102010": @{@"province": @"北京市", @"city": @"市辖区", @"district": @"西城区", @"street": @"德胜街道"},
@"110102011": @{@"province": @"北京市", @"city": @"市辖区", @"district": @"西城区", @"street": @"金融街街道"},
@"110102012": @{@"province": @"北京市", @"city": @"市辖区", @"district": @"西城区", @"street": @"什刹海街道"},
@"110102013": @{@"province": @"北京市", @"city": @"市辖区", @"district": @"西城区", @"street": @"大栅栏街道"},
@"110102014": @{@"province": @"北京市", @"city": @"市辖区", @"district": @"西城区", @"street": @"天桥街道"},
@"110102015": @{@"province": @"北京市", @"city": @"市辖区", @"district": @"西城区", @"street": @"椿树街道"},
@"110102016": @{@"province": @"北京市", @"city": @"市辖区", @"district": @"西城区", @"street": @"陶然亭街道"},
@"110102017": @{@"province": @"北京市", @"city": @"市辖区", @"district": @"西城区", @"street": @"广安门内街道"},
@"110102018": @{@"province": @"北京市", @"city": @"市辖区", @"district": @"西城区", @"street": @"牛街街道"},
@"110102019": @{@"province": @"北京市", @"city": @"市辖区", @"district": @"西城区", @"street": @"白纸坊街道"},
@"110102020": @{@"province": @"北京市", @"city": @"市辖区", @"district": @"西城区", @"street": @"广安门外街道"},
@"110105001": @{@"province": @"北京市", @"city": @"市辖区", @"district": @"朝阳区", @"street": @"建外街道"},
@"110105002": @{@"province": @"北京市", @"city": @"市辖区", @"district": @"朝阳区", @"street": @"朝外街道"},
@"110105003": @{@"province": @"北京市", @"city": @"市辖区", @"district": @"朝阳区", @"street": @"呼家楼街道"},
@"110105004": @{@"province": @"北京市", @"city": @"市辖区", @"district": @"朝阳区", @"street": @"三里屯街道"},
@"110105005": @{@"province": @"北京市", @"city": @"市辖区", @"district": @"朝阳区", @"street": @"左家庄街道"},
@"110105006": @{@"province": @"北京市", @"city": @"市辖区", @"district": @"朝阳区", @"street": @"香河园街道"},
@"110105007": @{@"province": @"北京市", @"city": @"市辖区", @"district": @"朝阳区", @"street": @"和平街街道"},
@"110105008": @{@"province": @"北京市", @"city": @"市辖区", @"district": @"朝阳区", @"street": @"安贞街道"},
@"110105009": @{@"province": @"北京市", @"city": @"市辖区", @"district": @"朝阳区", @"street": @"亚运村街道"},
@"110105010": @{@"province": @"北京市", @"city": @"市辖区", @"district": @"朝阳区", @"street": @"小关街道"},
@"110105011": @{@"province": @"北京市", @"city": @"市辖区", @"district": @"朝阳区", @"street": @"酒仙桥街道"},
@"110105012": @{@"province": @"北京市", @"city": @"市辖区", @"district": @"朝阳区", @"street": @"麦子店街道"},
@"110105013": @{@"province": @"北京市", @"city": @"市辖区", @"district": @"朝阳区", @"street": @"团结湖街道"},
@"110105014": @{@"province": @"北京市", @"city": @"市辖区", @"district": @"朝阳区", @"street": @"六里屯街道"},
@"110105015": @{@"province": @"北京市", @"city": @"市辖区", @"district": @"朝阳区", @"street": @"八里庄街道"},
@"110105016": @{@"province": @"北京市", @"city": @"市辖区", @"district": @"朝阳区", @"street": @"双井街道"},
@"110105017": @{@"province": @"北京市", @"city": @"市辖区", @"district": @"朝阳区", @"street": @"劲松街道"},
@"110105018": @{@"province": @"北京市", @"city": @"市辖区", @"district": @"朝阳区", @"street": @"潘家园街道"},
@"110105019": @{@"province": @"北京市", @"city": @"市辖区", @"district": @"朝阳区", @"street": @"垡头街道"},
@"110105020": @{@"province": @"北京市", @"city": @"市辖区", @"district": @"朝阳区", @"street": @"首都机场街道"},
@"110105021": @{@"province": @"北京市", @"city": @"市辖区", @"district": @"朝阳区", @"street": @"南磨房地区"},
@"110105022": @{@"province": @"北京市", @"city": @"市辖区", @"district": @"朝阳区", @"street": @"高碑店地区"},
@"110105023": @{@"province": @"北京市", @"city": @"市辖区", @"district": @"朝阳区", @"street": @"将台地区"},
@"110105024": @{@"province": @"北京市", @"city": @"市辖区", @"district": @"朝阳区", @"street": @"太阳宫地区"},
@"110105025": @{@"province": @"北京市", @"city": @"市辖区", @"district": @"朝阳区", @"street": @"大屯街道"},
@"110105026": @{@"province": @"北京市", @"city": @"市辖区", @"district": @"朝阳区", @"street": @"望京街道"},
@"110105027": @{@"province": @"北京市", @"city": @"市辖区", @"district": @"朝阳区", @"street": @"小红门地区"},
@"110105028": @{@"province": @"北京市", @"city": @"市辖区", @"district": @"朝阳区", @"street": @"十八里店地区"},
@"110105029": @{@"province": @"北京市", @"city": @"市辖区", @"district": @"朝阳区", @"street": @"平房地区"},
@"110105030": @{@"province": @"北京市", @"city": @"市辖区", @"district": @"朝阳区", @"street": @"东风地区"},
@"110105031": @{@"province": @"北京市", @"city": @"市辖区", @"district": @"朝阳区", @"street": @"奥运村街道"},
@"110105032": @{@"province": @"北京市", @"city": @"市辖区", @"district": @"朝阳区", @"street": @"来广营地区"},
@"110105033": @{@"province": @"北京市", @"city": @"市辖区", @"district": @"朝阳区", @"street": @"常营地区"},
@"110105034": @{@"province": @"北京市", @"city": @"市辖区", @"district": @"朝阳区", @"street": @"三间房地区"},
@"110105035": @{@"province": @"北京市", @"city": @"市辖区", @"district": @"朝阳区", @"street": @"管庄地区"},
@"110105036": @{@"province": @"北京市", @"city": @"市辖区", @"district": @"朝阳区", @"street": @"金盏地区"},
@"110105037": @{@"province": @"北京市", @"city": @"市辖区", @"district": @"朝阳区", @"street": @"孙河地区"},
@"110105038": @{@"province": @"北京市", @"city": @"市辖区", @"district": @"朝阳区", @"street": @"崔各庄地区"},
@"110105039": @{@"province": @"北京市", @"city": @"市辖区", @"district": @"朝阳区", @"street": @"东坝地区"},
@"110105040": @{@"province": @"北京市", @"city": @"市辖区", @"district": @"朝阳区", @"street": @"黑庄户地区"},
@"110105041": @{@"province": @"北京市", @"city": @"市辖区", @"district": @"朝阳区", @"street": @"豆各庄地区"},
@"110105042": @{@"province": @"北京市", @"city": @"市辖区", @"district": @"朝阳区", @"street": @"王四营地区"},
@"110105043": @{@"province": @"北京市", @"city": @"市辖区", @"district": @"朝阳区", @"street": @"东湖街道"},
@"110106001": @{@"province": @"北京市", @"city": @"市辖区", @"district": @"丰台区", @"street": @"右安门街道"},
@"110106002": @{@"province": @"北京市", @"city": @"市辖区", @"district": @"丰台区", @"street": @"太平桥街道"},
@"110106003": @{@"province": @"北京市", @"city": @"市辖区", @"district": @"丰台区", @"street": @"西罗园街道"},
@"110106004": @{@"province": @"北京市", @"city": @"市辖区", @"district": @"丰台区", @"street": @"大红门街道"},
@"110106005": @{@"province": @"北京市", @"city": @"市辖区", @"district": @"丰台区", @"street": @"南苑街道"},
@"110106006": @{@"province": @"北京市", @"city": @"市辖区", @"district": @"丰台区", @"street": @"东高地街道"},
@"110106007": @{@"province": @"北京市", @"city": @"市辖区", @"district": @"丰台区", @"street": @"东铁匠营街道"},
@"110106008": @{@"province": @"北京市", @"city": @"市辖区", @"district": @"丰台区", @"street": @"六里桥街道"},
@"110106009": @{@"province": @"北京市", @"city": @"市辖区", @"district": @"丰台区", @"street": @"丰台街道"},
@"110106010": @{@"province": @"北京市", @"city": @"市辖区", @"district": @"丰台区", @"street": @"新村街道"},
@"110106011": @{@"province": @"北京市", @"city": @"市辖区", @"district": @"丰台区", @"street": @"长辛店街道"},
@"110106012": @{@"province": @"北京市", @"city": @"市辖区", @"district": @"丰台区", @"street": @"云岗街道"},
@"110106013": @{@"province": @"北京市", @"city": @"市辖区", @"district": @"丰台区", @"street": @"方庄街道"},
@"110106014": @{@"province": @"北京市", @"city": @"市辖区", @"district": @"丰台区", @"street": @"宛平街道"},
@"110106015": @{@"province": @"北京市", @"city": @"市辖区", @"district": @"丰台区", @"street": @"马家堡街道"},
@"110106016": @{@"province": @"北京市", @"city": @"市辖区", @"district": @"丰台区", @"street": @"和义街道"},
@"110106017": @{@"province": @"北京市", @"city": @"市辖区", @"district": @"丰台区", @"street": @"卢沟桥街道"},
@"110106018": @{@"province": @"北京市", @"city": @"市辖区", @"district": @"丰台区", @"street": @"花乡街道"},
@"110106020": @{@"province": @"北京市", @"city": @"市辖区", @"district": @"丰台区", @"street": @"成寿寺街道"},
@"110106021": @{@"province": @"北京市", @"city": @"市辖区", @"district": @"丰台区", @"street": @"石榴庄街道"},
@"110106022": @{@"province": @"北京市", @"city": @"市辖区", @"district": @"丰台区", @"street": @"玉泉营街道"},
@"110106023": @{@"province": @"北京市", @"city": @"市辖区", @"district": @"丰台区", @"street": @"看丹街道"},
@"110106024": @{@"province": @"北京市", @"city": @"市辖区", @"district": @"丰台区", @"street": @"五里店街道"},
@"110106025": @{@"province": @"北京市", @"city": @"市辖区", @"district": @"丰台区", @"street": @"青塔街道"},
@"110106100": @{@"province": @"北京市", @"city": @"市辖区", @"district": @"丰台区", @"street": @"北宫镇"},
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