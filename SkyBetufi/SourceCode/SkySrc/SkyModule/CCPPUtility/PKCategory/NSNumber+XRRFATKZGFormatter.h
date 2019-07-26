//
//  NSNumber+XRRFATKZGFormatter.h
//  ZGFinance
//
//  Created by Marco on 2017/12/6.
//  Copyright © 2017年 Zhugelicai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNumber (XRRFATKZGFormatter)

- (NSString *)roundDownFormat2Digit; //两位小数，后面的抹掉
- (NSString *)roundDownFormatMax2Digit; //最多两位小数，后面的抹掉


- (NSDecimalNumber *)decimalNumberWithMax2Digit;
- (NSString *)stringValueWithMax2Digit;

@end
