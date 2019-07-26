//
//  XRRFATKBJUtility.h
//  BenjiaPro
//
//  Created by Marco on 2017/6/1.
//  Copyright © 2017年 Benjia. All rights reserved.
//

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

/**
 *
 *  @param key 键
 *
 *  @return 值
 */
+ (id)valueInPlistForKey:(NSString *)key;

/**
 *  获取App版本号, 从plist从读取CFBundleShortVersion
 */
+ (NSString *)appVersion;

/**
 *  获取AppBuild号, 从plist中读取CFBundleVersion
 */
+ (NSString *)appBuild;

/**
 *  获取bundle id
 *
 *  @return bundle id
 */
+ (NSString *)appBundleId;

/**
 *  获取当前的构建类型(DEBUG/RELEASE)
 *
 *  @return 构建类型
 */
+ (NSString *)buildType;

@end


@interface XRRFATKBJUtility (Device)

/**
 *  获取modelName, 如iPhone5,2
 */
+ (NSString *)modelName;

/**
 *  获取系统版本
 */
+ (NSString *)systemVersion;

+ (NSString *)idfa;

@end

@interface XRRFATKBJUtility (Carrier)


/**
 获取运营商

 @return 运营商名称
 */
+ (NSString *)carrierName;

@end
