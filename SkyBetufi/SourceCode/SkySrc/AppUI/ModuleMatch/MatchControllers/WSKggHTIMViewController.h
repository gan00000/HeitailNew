//
//  WSKggHTIMViewController.h
//  SkyBallPlay
//
//  Created by ganyuanrong on 2020/9/12.
//  Copyright © 2020 Dean_F. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMoogPPXXBJBaseViewController.h"
#import "TuTuosHTMatchHomeModel.h"
#import "KSasxHTMatchSummaryModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface WSKggHTIMViewController : MMoogPPXXBJBaseViewController

-(void)setData:(TuTuosHTMatchHomeModel *)model summary:(KSasxHTMatchSummaryModel *)summaryModel;
@end

NS_ASSUME_NONNULL_END
