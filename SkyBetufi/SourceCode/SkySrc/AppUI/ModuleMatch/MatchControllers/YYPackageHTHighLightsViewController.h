//
//  YYPackageHTHighLightsViewController.h
//  
//
//  Created by ganyuanrong on 2021/3/12.
//  Copyright © 2021 Dean_F. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCCasePPXXBJBaseViewController.h"
#import "PXFunHTMatchCompareModel.h"
#import "SundayHTMatchHomeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface YYPackageHTHighLightsViewController : CCCasePPXXBJBaseViewController

//-(void)refreshDataWithGameId:(NSString *)game_id;

-(void)refreshDataWithGameId:(NSString *)game_id mMatchSummaryModel:(NDeskHTMatchSummaryModel *)matchModel mCompareModel:(PXFunHTMatchCompareModel *)matchCompareModel;

@end

NS_ASSUME_NONNULL_END
