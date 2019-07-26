//
//  XRRFATKHTMatchSubDsbdViewController.h
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/10/14.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import "XRRFATKPPXXBJBaseViewController.h"
#import "XRRFATKHTMatchDetailsModel.h"

@interface XRRFATKHTMatchSubDsbdViewController : XRRFATKPPXXBJBaseViewController

- (void)refreshWithDetailList:(NSArray<XRRFATKHTMatchDetailsModel *> *)detailList;

@end
