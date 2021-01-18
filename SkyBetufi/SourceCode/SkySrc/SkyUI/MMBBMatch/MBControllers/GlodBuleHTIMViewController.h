//
//  GlodBuleHTIMViewController.h
//  SkyBallPlay
//
//  Created by ganyuanrong on 2020/9/12.
//  Copyright © 2020 Dean_F. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlodBulePPXXBJBaseViewController.h"
#import "GlodBuleHTMatchHomeModel.h"
#import "GlodBuleHTMatchSummaryModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface GlodBuleHTIMViewController : GlodBulePPXXBJBaseViewController

-(void)setData:(GlodBuleHTMatchHomeModel *)model summary:(GlodBuleHTMatchSummaryModel *)summaryModel;
@end

NS_ASSUME_NONNULL_END
