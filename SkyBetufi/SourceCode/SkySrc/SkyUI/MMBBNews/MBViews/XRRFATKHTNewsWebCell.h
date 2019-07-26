//
//  XRRFATKHTNewsWebCell.h
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/9/10.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XRRFATKHTNewsWebCell : UITableViewCell

@property (nonatomic, copy) void(^onContentHeightUpdateBlock)(CGFloat height);

- (void)setupWithClearHtmlContent:(NSString *)htmlContent;

@end
