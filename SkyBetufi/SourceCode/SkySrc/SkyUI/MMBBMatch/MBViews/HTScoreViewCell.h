//
//  HTScoreViewCell.h
//  SkyBallPlay
//
//  Created by ganyuanrong on 2020/9/18.
//  Copyright © 2020 Dean_F. All rights reserved.
//

#import <UIKit/UIKit.h>
@import Charts;
#import "SkyBallHetiRedHTMatchSummaryModel.h"
#import "SkyBallHetiRedHTMatchLiveFeedModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HTScoreViewCell : UITableViewCell

- (void)setMatchSummaryModel:(SkyBallHetiRedHTMatchSummaryModel *)summaryModel liveFeedModel:(NSArray<SkyBallHetiRedHTMatchLiveFeedModel *> *)liveFeedModel;

@end

NS_ASSUME_NONNULL_END
