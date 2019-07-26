//
//  UIScrollView+XRRFATKAllowScreenEdgePanGestureRecognizer.m
//  PagerViewDemo
//
//  Created by Marco on 1/23/15.
//  Copyright (c) 2015 LJ. All rights reserved.
//

#import "UIScrollView+XRRFATKAllowScreenEdgePanGestureRecognizer.h"

@implementation UIScrollView (XRRFATKAllowScreenEdgePanGestureRecognizer)

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
    shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]
        && [otherGestureRecognizer isKindOfClass:[UIScreenEdgePanGestureRecognizer class]]) {
        return YES;
    } else {
        return  NO;
    }
}

@end
