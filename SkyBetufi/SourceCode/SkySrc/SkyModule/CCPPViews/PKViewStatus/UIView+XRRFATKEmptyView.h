//
//  UIView+XRRFATKEmptyView.h
//  Exchange
//
//  Created by Marco on 2017/3/7.
//  Copyright © 2017年 zhugelicai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (XRRFATKEmptyView)

- (void)showEmptyView;
- (void)showEmptyViewWithEdge:(UIEdgeInsets)edge;
- (void)showEmptyViewWithTitle:(NSString *)title;
- (void)showEmptyViewWithTitle:(NSString *)title edge:(UIEdgeInsets)edge;
- (void)showEmptyViewWithTitle:(NSString *)title tapBlock:(dispatch_block_t)tapBlock;
- (void)showEmptyViewWithTitle:(NSString *)title tapBlock:(dispatch_block_t)tapBlock edge:(UIEdgeInsets)edge;

- (void)showEmptyViewWithImage:(UIImage *)image;
- (void)showEmptyViewWithImage:(UIImage *)image edge:(UIEdgeInsets)edge;
- (void)showEmptyViewWithImage:(UIImage *)image title:(NSString *)title;
- (void)showEmptyViewWithImage:(UIImage *)image title:(NSString *)title edge:(UIEdgeInsets)edge;
- (void)showEmptyViewWithImage:(UIImage *)image title:(NSString *)title tapBlock:(dispatch_block_t)tapBlock;
- (void)showEmptyViewWithImage:(UIImage *)image title:(NSString *)title tapBlock:(dispatch_block_t)tapBlock edge:(UIEdgeInsets)edge;

- (void)hideEmptyView;

- (void)updateEmptyViewColor:(UIColor *)bgColor;

@end
