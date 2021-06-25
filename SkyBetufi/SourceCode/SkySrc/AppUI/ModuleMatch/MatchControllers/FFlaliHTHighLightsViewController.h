//
//  FFlaliHTHighLightsViewController.h
//  
//
//  Created by ganyuanrong on 2021/3/12.
//  Copyright © 2021 Dean_F. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSKggPPXXBJBaseViewController.h"
#import "WSKggHTMatchCompareModel.h"
#import "FFlaliHTMatchHomeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FFlaliHTHighLightsViewController : WSKggPPXXBJBaseViewController

//-(void)refreshDataWithGameId:(NSString *)game_id;

-(void)refreshDataWithGameId:(NSString *)game_id mMatchSummaryModel:(NSNiceHTMatchSummaryModel *)matchModel mCompareModel:(WSKggHTMatchCompareModel *)matchCompareModel;

@end

NS_ASSUME_NONNULL_END
