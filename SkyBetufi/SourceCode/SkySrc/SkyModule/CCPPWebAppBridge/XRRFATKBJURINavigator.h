//
//  XRRFATKBJURINavigator.h
//  BenjiaPro
//
//  Created by Marco on 2017/6/26.
//  Copyright © 2017年 Benjia. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString * const BJURIScheme = @"zglc";

@interface XRRFATKBJURINavigator : NSObject

+ (instancetype)sharedInstance;

- (BOOL)canHandleURI:(NSString *)uri;
- (BOOL)handleURI:(NSString *)uri;

@end
