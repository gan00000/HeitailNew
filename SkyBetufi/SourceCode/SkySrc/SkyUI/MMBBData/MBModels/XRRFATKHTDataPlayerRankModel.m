//
//  XRRFATKHTDataPlayerRankModel.m
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/10/19.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import "XRRFATKHTDataPlayerRankModel.h"

@implementation XRRFATKHTDataPlayerRankModel

- (NSString *)name {
    if (!_name) {
        _name = [NSString stringWithFormat:@"%@.%@", [self.firstname substringToIndex:1], self.lastname];
    }
    return _name;
}

@end
