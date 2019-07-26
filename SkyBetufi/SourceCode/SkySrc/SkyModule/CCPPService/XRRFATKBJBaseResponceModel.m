//
//  XRRFATKBJBaseResponceModel.m
//  BenjiaPro
//
//  Created by 吕磊 on 2017/5/26.
//  Copyright © 2017年 Benjia. All rights reserved.
//
#import "XRRFATKBJBaseResponceModel.h"

@implementation XRRFATKBJBaseResponceModel

- (NSInteger)pagesValueOfPage {
    if (self.page) {
        return [self.page[@"pages"] integerValue];
    }
    return 0;
}

- (NSInteger)totalValueOfPage {
//    if (self.page) {
//        return [self.page[@"total"] integerValue];
//    }
//    return 0;
    return self.total;
}

@end
