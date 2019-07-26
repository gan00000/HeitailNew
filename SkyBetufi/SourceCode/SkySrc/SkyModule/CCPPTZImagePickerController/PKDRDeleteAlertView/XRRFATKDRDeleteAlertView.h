//
//  XRRFATKDRDeleteAlertView.h
//  Records
//
//  Created by Jeason on 2018/1/4.
//  Copyright © 2018年 DuoRong Technology Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^DRNoteTagDeleteAlertViewCompleteBlock)(BOOL isDelete);

@interface XRRFATKDRDeleteAlertView : UIView

+ (void)showDeleteAlertViewWithComplete:(DRNoteTagDeleteAlertViewCompleteBlock)complete;

+ (void)showTagDeleteAlertViewWithComplete:(DRNoteTagDeleteAlertViewCompleteBlock)complete;

+ (void)showWithTitle:(NSString *)title message:(NSString *)message content:(NSString *)content complete:(DRNoteTagDeleteAlertViewCompleteBlock)complete;

@end
