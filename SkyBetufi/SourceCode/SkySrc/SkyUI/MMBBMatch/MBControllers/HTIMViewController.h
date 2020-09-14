//
//  HTIMViewController.h
//  SkyBallPlay
//
//  Created by ganyuanrong on 2020/9/12.
//  Copyright © 2020 Dean_F. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SkyBallHetiRedPPXXBJBaseViewController.h"
#import "SkyBallHetiRedHTMatchHomeModel.h"
#import "SkyBallHetiRedHTMatchSummaryModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HTIMViewController : SkyBallHetiRedPPXXBJBaseViewController

-(void)setData:(SkyBallHetiRedHTMatchHomeModel *)model summary:(SkyBallHetiRedHTMatchSummaryModel *)summaryModel;
@end

NS_ASSUME_NONNULL_END
