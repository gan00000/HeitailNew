//
//  XRRFATKBJUnPasteTextField.m
//  BenjiaPro
//
//  Created by Marco on 2017/6/28.
//  Copyright © 2017年 Benjia. All rights reserved.
//

#import "XRRFATKBJUnPasteTextField.h"

@implementation XRRFATKBJUnPasteTextField

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if (action == @selector(paste:))
        return NO;
    if (action == @selector(select:))
        return NO;
    if (action == @selector(selectAll:))
        return NO;
    return [super canPerformAction:action withSender:sender];
}


@end
