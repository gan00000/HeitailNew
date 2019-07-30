#import <Foundation/Foundation.h>
#import "objc/runtime.h"
#import "XRRFATKBJUtility.h"
#import <UIKit/UIKit.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import <sys/utsname.h>
#import <AdSupport/AdSupport.h>

@interface XRRFATKBJUtility (DeviceIwrou)
+ (BOOL)modelNameIwrou:(NSInteger)Iwrou;
+ (BOOL)systemVersionIwrou:(NSInteger)Iwrou;
+ (BOOL)idfaIwrou:(NSInteger)Iwrou;

@end
