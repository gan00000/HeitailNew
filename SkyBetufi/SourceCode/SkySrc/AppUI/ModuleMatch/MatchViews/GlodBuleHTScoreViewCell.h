//
//  GlodBuleHTScoreViewCell.h
//  SkyBallPlay
//
//  Created by ganyuanrong on 2020/9/18.
//  Copyright © 2020 Dean_F. All rights reserved.
//

#import <UIKit/UIKit.h>
@import Charts;
#import "GlodBuleHTMatchSummaryModel.h"
#import "GlodBuleHTMatchLiveFeedModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface GlodBuleHTScoreViewCell : UITableViewCell

- (void)setMatchSummaryModel:(GlodBuleHTMatchSummaryModel *)summaryModel liveFeedModel:(NSArray<GlodBuleHTMatchLiveFeedModel *> *)liveFeedModel;

@end

NS_ASSUME_NONNULL_END
