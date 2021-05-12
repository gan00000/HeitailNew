//
//  HourseHTScoreViewCell.h
//  SkyBallPlay
//
//  Created by ganyuanrong on 2020/9/18.
//  Copyright © 2020 Dean_F. All rights reserved.
//

#import <UIKit/UIKit.h>
@import Charts;
#import "NDeskHTMatchSummaryModel.h"
#import "SundayHTMatchLiveFeedModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HourseHTScoreViewCell : UITableViewCell

- (void)setMatchSummaryModel:(NDeskHTMatchSummaryModel *)summaryModel liveFeedModel:(NSArray<SundayHTMatchLiveFeedModel *> *)liveFeedModel;

@end

NS_ASSUME_NONNULL_END
