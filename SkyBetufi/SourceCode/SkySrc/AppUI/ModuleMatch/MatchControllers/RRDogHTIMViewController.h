//
//  RRDogHTIMViewController.h
//  SkyBallPlay
//
//  Created by ganyuanrong on 2020/9/12.
//  Copyright © 2020 Dean_F. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCCasePPXXBJBaseViewController.h"
#import "SundayHTMatchHomeModel.h"
#import "NDeskHTMatchSummaryModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface RRDogHTIMViewController : CCCasePPXXBJBaseViewController

-(void)setData:(SundayHTMatchHomeModel *)model summary:(NDeskHTMatchSummaryModel *)summaryModel;
@end

NS_ASSUME_NONNULL_END
