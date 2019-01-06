#import "HBBJUtility+AppMixcode.h"
@implementation HBBJUtility (AppMixcode)
+ (void)valueInPlistForKey:(NSString *)key mixcode:(NSString *)mixcode {
    NSLog(@"%@", mixcode);
}
+ (void)appVersionMixcode:(NSString *)mixcode {
    NSLog(@"%@", mixcode);
}
+ (void)appBuildMixcode:(NSString *)mixcode {
    NSLog(@"%@", mixcode);
}
+ (void)appBundleIdMixcode:(NSString *)mixcode {
    NSLog(@"%@", mixcode);
}
+ (void)buildTypeMixcode:(NSString *)mixcode {
    NSLog(@"%@", mixcode);
}

@end
