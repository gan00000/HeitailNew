//
//  XRRFATKHTDatePickerView.h
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/9/14.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef BOOL(^HTDatePickerEnterBlock)(NSDate *date);

@interface XRRFATKHTDatePickerView : UIView

+ (void)showWithWithDate:(NSDate *)date
        didTapEnterBlock:(HTDatePickerEnterBlock)enterBlock;

@end
