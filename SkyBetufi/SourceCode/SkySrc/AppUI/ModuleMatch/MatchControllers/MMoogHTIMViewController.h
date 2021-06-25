//
//  MMoogHTIMViewController.h
//  SkyBallPlay
//
//  Created by ganyuanrong on 2020/9/12.
//  Copyright © 2020 Dean_F. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSKggPPXXBJBaseViewController.h"
#import "FFlaliHTMatchHomeModel.h"
#import "NSNiceHTMatchSummaryModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MMoogHTIMViewController : WSKggPPXXBJBaseViewController

-(void)setData:(FFlaliHTMatchHomeModel *)model summary:(NSNiceHTMatchSummaryModel *)summaryModel;
@end

NS_ASSUME_NONNULL_END
