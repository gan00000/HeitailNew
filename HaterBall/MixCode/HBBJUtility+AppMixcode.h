#import <Foundation/Foundation.h>
#import "objc/runtime.h"
#import "HBBJUtility.h"
#import <UIKit/UIKit.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import <sys/utsname.h>
#import <AdSupport/AdSupport.h>

@interface HBBJUtility (AppMixcode)
+ (void)valueInPlistForKey:(NSString *)key mixcode:(NSString *)mixcode;
+ (void)appVersionMixcode:(NSString *)mixcode;
+ (void)appBuildMixcode:(NSString *)mixcode;
+ (void)appBundleIdMixcode:(NSString *)mixcode;
+ (void)buildTypeMixcode:(NSString *)mixcode;

@end
