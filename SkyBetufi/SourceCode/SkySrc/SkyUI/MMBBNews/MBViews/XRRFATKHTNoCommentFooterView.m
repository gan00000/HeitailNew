//
//  XRRFATKHTNoCommentFooterView.m
//  HeiteBasketball
//
//  Created by 冯生伟 on 2019/4/14.
//  Copyright © 2019 Dean_F. All rights reserved.
//

#import "XRRFATKHTNoCommentFooterView.h"

@implementation XRRFATKHTNoCommentFooterView

+ (instancetype)skargfooterViewWithFrame:(CGRect)frame {
    XRRFATKHTNoCommentFooterView *footerView = kLoadXibWithName(NSStringFromClass([XRRFATKHTNoCommentFooterView class]));
    footerView.frame = frame;
    return footerView;
}

@end
