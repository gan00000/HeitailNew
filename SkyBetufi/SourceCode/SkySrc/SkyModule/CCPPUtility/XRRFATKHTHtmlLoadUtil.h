//
//  XRRFATKHTHtmlLoadUtil.h
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/9/10.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XRRFATKHTHtmlLoadUtil : NSObject

+ (instancetype)sharedInstance;
- (NSString *)svgHtmlWithUrl:(NSString *)img_url width:(NSInteger)width;
- (NSString *)iframHtmlWithContent:(NSString *)iframe_content;

@end
