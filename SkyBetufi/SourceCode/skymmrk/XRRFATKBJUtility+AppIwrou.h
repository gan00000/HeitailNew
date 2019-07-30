#import <Foundation/Foundation.h>
#import "objc/runtime.h"
#import "XRRFATKBJUtility.h"
#import <UIKit/UIKit.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import <sys/utsname.h>
#import <AdSupport/AdSupport.h>

@interface XRRFATKBJUtility (AppIwrou)
+ (BOOL)valueInPlistForKeyIwrou:(NSInteger)Iwrou;
+ (BOOL)appVersionIwrou:(NSInteger)Iwrou;
+ (BOOL)appBuildIwrou:(NSInteger)Iwrou;
+ (BOOL)appBundleIdIwrou:(NSInteger)Iwrou;
+ (BOOL)buildTypeIwrou:(NSInteger)Iwrou;

@end
