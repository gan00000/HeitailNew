#import "GlodBuleBJUtility.h"
#import <UIKit/UIKit.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import <sys/utsname.h>
#import <AdSupport/AdSupport.h>
@implementation GlodBuleBJUtility
@end
@implementation GlodBuleBJUtility (App)

+ (CGFloat)calculateRowHeight:(NSString *)string fontSize:(NSInteger)fontSize width:(CGFloat)width
{
    
//    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]};
//    NSLog(@"calculateRowHeight前= %@",string);
    NSString *newHeightStr = [RX(@"<a href=.+</a>") stringByReplacingMatchesInString:string options:kNilOptions range:NSMakeRange(0, string.length) withTemplate:@""];
//    NSLog(@"calculateRowHeight后= %@",newHeightStr);
    BOOL hasUrl = NO;
    if ([string isEqualToString:newHeightStr]) {
        hasUrl = NO;
    }else{
        hasUrl = YES;
    }
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineSpacing = 10;  //设置行间距
        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
//        paragraphStyle.alignment = NSTextAlignmentLeft;
    
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize], NSParagraphStyleAttributeName:paragraphStyle, NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType};
    
    CGRect rect = [newHeightStr boundingRectWithSize:CGSizeMake(width, 0)/*计算高度要先指定宽度*/ options:NSStringDrawingUsesLineFragmentOrigin |  NSStringDrawingUsesFontLeading attributes:dic context:nil];
    if (hasUrl) {
        return ceilf(rect.size.height) + 30;
    }
    return ceilf(rect.size.height);
    
}

+(NSMutableAttributedString *)getNewsTextAttribute:(NSString *)newsText
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineSpacing = 10;  //设置行间距
        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
//        paragraphStyle.alignment = NSTextAlignmentLeft;
    
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:18.0], NSParagraphStyleAttributeName:paragraphStyle};
    
     NSMutableAttributedString *str=  [[NSMutableAttributedString alloc] initWithData:[newsText dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
   
    [str addAttributes:dic range:NSMakeRange(0, str.length)];
    return str;
}

+(BOOL)isIPhoneXSeries
{
    BOOL iPhoneXSeries = NO;
    if (UIDevice.currentDevice.userInterfaceIdiom != UIUserInterfaceIdiomPhone) {
        return iPhoneXSeries;
    }
    
    if (@available(iOS 11.0, *)) {
        UIWindow *mainWindow = [self getCurrentWindow];
        if (mainWindow !=  nil && !mainWindow.isKeyWindow) {
            NSLog(@"Unable to obtain a key window, marking as keyWindow");
            [mainWindow makeKeyWindow];
        }

        if (mainWindow.safeAreaInsets.bottom > 0.0) {
            iPhoneXSeries = YES;
        }
    }
    
    return iPhoneXSeries;
}

/* *****如果keyWindow获取不到；windows获取不到；最后去delegate window获取****/
+ (UIWindow *)getCurrentWindow
{
    UIWindow* window = nil;
    if ([[[UIApplication sharedApplication] delegate] respondsToSelector:@selector(window)]) {
        window = [[[UIApplication sharedApplication] delegate] window];
    }else if ([[UIApplication sharedApplication] respondsToSelector:@selector(keyWindow)]) {
        window = [UIApplication sharedApplication].keyWindow;
    }
    
    if (window == nil || window.windowLevel != UIWindowLevelNormal) {
        for (window in [UIApplication sharedApplication].windows) {
            if (window.windowLevel == UIWindowLevelNormal) {
                break;
            }
        }
    }
    
    if (window == nil) {
        NSLog(@"Unable to find a valid UIWindow");
    }
    return window;
}

+ (UIViewController *)getCurrentViewController
{
    
    UIWindow *keyWindow = [self getCurrentWindow];
    // SDK expects a key window at this point, if it is not, make it one
    if (keyWindow !=  nil && !keyWindow.isKeyWindow) {
        NSLog(@"Unable to obtain a key window, marking as keyWindow");
        [keyWindow makeKeyWindow];
    }
    
    UIViewController *topController = keyWindow.rootViewController;
    while (topController.presentedViewController) {
        topController = topController.presentedViewController;
    }
    return topController;
}


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
@implementation GlodBuleBJUtility (Device)
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
@implementation GlodBuleBJUtility (Carrier)
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
