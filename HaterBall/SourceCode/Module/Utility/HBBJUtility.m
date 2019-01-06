#import "HBBJUtility.h"
#import <UIKit/UIKit.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import <sys/utsname.h>
#import <AdSupport/AdSupport.h>
@implementation HBBJUtility
@end
@implementation HBBJUtility (App)
+ (id)valueInPlistForKey:(NSString *)key {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    return [infoDictionary objectForKey:key];
}
+ (NSString *)appVersion {
    static NSString *appVersion = nil;
    if (!appVersion) {
        appVersion = [self valueInPlistForKey:@"CFBundleShortVersionString"];
    }
    return appVersion;
}
+ (NSString *)appBuild {
    static NSString *appBuild = nil;
    if (!appBuild) {
        appBuild = [self valueInPlistForKey:(NSString *)kCFBundleVersionKey];
    }
    return appBuild;
}
+ (NSString *)appBundleId {
    static NSString *appBundleId = nil;
    if (!appBundleId) {
        appBundleId = [self valueInPlistForKey:(NSString *)kCFBundleIdentifierKey];
    }
    return appBundleId;
}
+ (NSString *)buildType {
#ifdef DEBUG
    return @"DEBUG";
#else
    return @"RELEASE";
#endif
}
@end
@implementation HBBJUtility (Device)
+ (NSString *)modelName {
    static NSString *modelName = nil;
    if (!modelName) {
        struct utsname systemInfo;
        uname(&systemInfo);
        modelName = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    }
    return modelName;
}
+ (NSString *)systemVersion {
    static NSString* _systemVersion = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _systemVersion = [UIDevice currentDevice].systemVersion;
    });
    return _systemVersion;
}
+ (NSString *)idfa {
    static NSString *idfa = nil;
    if (!idfa) {
        idfa = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    }
    return idfa;
}
@end
@implementation HBBJUtility (Carrier)
+ (NSString *)carrierName {
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [info subscriberCellularProvider];
    if (!carrier.carrierName) {
        return @"";
    }
    NSString *code = [NSString stringWithFormat:@"%@%@", carrier.mobileCountryCode, carrier.mobileNetworkCode];
    if ([code isEqualToString:@"46000"] || [code isEqualToString:@"46002"] || [code isEqualToString:@"46007"]) {
        return @"中国移动";
    }
    if ([code isEqualToString:@"46001"] || [code isEqualToString:@"46006"]) {
        return @"中国联通";
    }
    if ([code isEqualToString:@"46003"] || [code isEqualToString:@"46005"]) {
        return @"中国联通";
    }
    return carrier.carrierName;
}
@end
