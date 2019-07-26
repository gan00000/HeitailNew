//
//  XRRFATKBJURINavHelper.h
//  BenjiaPro
//
//  Created by Marco on 2017/7/3.
//  Copyright © 2017年 Benjia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XRRFATKBJURINavHelper : NSObject

+ (BOOL)canHandleURI:(NSString *)uri;
+ (void)handleURI:(NSString *)uri fromViewController:(UIViewController *)viewController;

@end
