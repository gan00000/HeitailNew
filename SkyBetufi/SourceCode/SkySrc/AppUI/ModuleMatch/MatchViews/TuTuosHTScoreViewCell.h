//
//  TuTuosHTScoreViewCell.h
//  SkyBallPlay
//
//  Created by ganyuanrong on 2020/9/18.
//  Copyright © 2020 Dean_F. All rights reserved.
//

#import <UIKit/UIKit.h>
@import Charts;
#import "NSNiceHTMatchSummaryModel.h"
#import "UUaksHTMatchLiveFeedModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TuTuosHTScoreViewCell : UITableViewCell

- (void)setMatchSummaryModel:(NSNiceHTMatchSummaryModel *)summaryModel liveFeedModel:(NSArray<UUaksHTMatchLiveFeedModel *> *)liveFeedModel;

@end

NS_ASSUME_NONNULL_END
