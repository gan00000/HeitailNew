#import <Foundation/Foundation.h>
#import "objc/runtime.h"
static inline void p_swizzleSelector(Class theClass, SEL originalSelector, SEL swizzledSelector) {
    Method originalMethod = class_getInstanceMethod(theClass, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(theClass, swizzledSelector);
    method_exchangeImplementations(originalMethod, swizzledMethod);
}
static inline BOOL p_addMethod(Class theClass, SEL selector, Method method) {
    return class_addMethod(theClass, selector,  method_getImplementation(method),  method_getTypeEncoding(method));
}
@interface XRRFATKBJUtility : NSObject
@end
@interface XRRFATKBJUtility (App)
+ (id)valueInPlistForKey:(NSString *)key;
+ (NSString *)appVersion;
+ (NSString *)appBuild;
+ (NSString *)appBundleId;
+ (NSString *)buildType;
@end
@interface XRRFATKBJUtility (Device)
+ (NSString *)modelName;
+ (NSString *)systemVersion;
+ (NSString *)idfa;
@end
@interface XRRFATKBJUtility (Carrier)
+ (NSString *)carrierName;
@end
