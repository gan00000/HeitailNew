#import "NSBundle+SkyBallHetiRedTZImagePicker.h"
#import "SkyBallHetiRedTZImagePickerController.h"
@implementation NSBundle (SkyBallHetiRedTZImagePicker)
+ (NSBundle *)tz_imagePickerBundle {
    NSBundle *bundle = [NSBundle bundleForClass:[SkyBallHetiRedTZImagePickerController class]];
    NSURL *url = [bundle URLForResource:@"SkyBallHetiRedTZImagePickerController" withExtension:@"bundle"];
    bundle = [NSBundle bundleWithURL:url];
    return bundle;
}
+ (NSString *)tz_localizedStringForKey:(NSString *)key {
    return [self tz_localizedStringForKey:key value:@""];
}
+ (NSString *)tz_localizedStringForKey:(NSString *)key value:(NSString *)value {
    static NSBundle *bundle = nil;
    if (bundle == nil) {
        NSString *language = [NSLocale preferredLanguages].firstObject;
        if ([language rangeOfString:@"zh-Hans"].location != NSNotFound) {
            language = @"zh-Hans";
        } else {
            language = @"en";
        }
        bundle = [NSBundle bundleWithPath:[[NSBundle tz_imagePickerBundle] pathForResource:language ofType:@"lproj"]];
    }
    NSString *value1 = [bundle localizedStringForKey:key value:value table:nil];
    return value1;
}
@end
