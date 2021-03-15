//
//  HTHighLightsViewController.h
//  XXXHeiTai
//
//  Created by ganyuanrong on 2021/3/12.
//  Copyright © 2021 Dean_F. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlodBulePPXXBJBaseViewController.h"
#import "GlodBuleHTMatchCompareModel.h"
#import "GlodBuleHTMatchHomeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HTHighLightsViewController : GlodBulePPXXBJBaseViewController

//-(void)refreshDataWithGameId:(NSString *)game_id;

-(void)refreshDataWithGameId:(NSString *)game_id mMatchSummaryModel:(GlodBuleHTMatchHomeModel *)matchModel mCompareModel:(GlodBuleHTMatchCompareModel *)matchCompareModel;

@end

NS_ASSUME_NONNULL_END
