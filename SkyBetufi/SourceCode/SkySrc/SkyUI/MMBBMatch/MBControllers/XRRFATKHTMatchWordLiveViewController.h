//
//  XRRFATKHTMatchWordLiveViewController.h
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/9/9.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import "XRRFATKPPXXBJBaseViewController.h"
#import "XRRFATKHTMatchLiveFeedModel.h"

@interface XRRFATKHTMatchWordLiveViewController : XRRFATKPPXXBJBaseViewController

@property (nonatomic, copy) void (^onTableHeaderRefreshBlock)(void);

- (void)skargrefreshWithLiveFeedList:(NSArray<XRRFATKHTMatchLiveFeedModel *> *)liveFeedList;

@end
