#import <Foundation/Foundation.h>
#import "objc/runtime.h"
#import "HBBJUtility.h"
#import <UIKit/UIKit.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import <sys/utsname.h>
#import <AdSupport/AdSupport.h>

@interface HBBJUtility (CarrierMixcode)
+ (void)carrierNameMixcode:(NSString *)mixcode;

@end
