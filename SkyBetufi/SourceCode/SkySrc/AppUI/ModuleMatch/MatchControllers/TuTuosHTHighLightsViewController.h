//
//  TuTuosHTHighLightsViewController.h
//  
//
//  Created by ganyuanrong on 2021/3/12.
//  Copyright © 2021 Dean_F. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMoogPPXXBJBaseViewController.h"
#import "BByasHTMatchCompareModel.h"
#import "TuTuosHTMatchHomeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TuTuosHTHighLightsViewController : MMoogPPXXBJBaseViewController

//-(void)refreshDataWithGameId:(NSString *)game_id;

-(void)refreshDataWithGameId:(NSString *)game_id mMatchSummaryModel:(KSasxHTMatchSummaryModel *)matchModel mCompareModel:(BByasHTMatchCompareModel *)matchCompareModel;

@end

NS_ASSUME_NONNULL_END
