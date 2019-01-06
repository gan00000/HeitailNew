#import <Foundation/Foundation.h>
#import "objc/runtime.h"
#import "HBBJUtility.h"
#import <UIKit/UIKit.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import <sys/utsname.h>
#import <AdSupport/AdSupport.h>

@interface HBBJUtility (DeviceMixcode)
+ (void)modelNameMixcode:(NSString *)mixcode;
+ (void)systemVersionMixcode:(NSString *)mixcode;
+ (void)idfaMixcode:(NSString *)mixcode;

@end
