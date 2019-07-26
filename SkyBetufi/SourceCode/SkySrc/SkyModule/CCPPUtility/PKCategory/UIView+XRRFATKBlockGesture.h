//
//  UIView+XRRFATKBlockGesture.h
//  BenjiaPro
//
//  Created by 叮咚钱包富银 on 2018/7/10.
//  Copyright © 2018年 冯生伟. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^GestureActionBlock)(UIGestureRecognizer *gestureRecoginzer);

@interface UIView (XRRFATKBlockGesture)
- (void)addTapActionWithBlock:(GestureActionBlock)block;
- (void)addLongPressActionWithBlock:(GestureActionBlock)block;
@end
