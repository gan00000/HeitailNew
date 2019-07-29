//
//  XRRFATKHTMatchCompareViewController.h
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/9/9.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import "XRRFATKPPXXBJBaseViewController.h"
#import "XRRFATKHTMatchSummaryModel.h"


@interface XRRFATKHTMatchCompareViewController : XRRFATKPPXXBJBaseViewController

@property (nonatomic, copy) void (^onTableHeaderRefreshBlock)(void);

- (void)skargrefreshWithMatchSummaryModel:(XRRFATKHTMatchSummaryModel *)summaryModel;

@end
