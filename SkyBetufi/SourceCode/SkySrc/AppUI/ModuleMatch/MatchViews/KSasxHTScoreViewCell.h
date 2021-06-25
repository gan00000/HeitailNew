//
//  KSasxHTScoreViewCell.h
//  SkyBallPlay
//
//  Created by ganyuanrong on 2020/9/18.
//  Copyright © 2020 Dean_F. All rights reserved.
//

#import <UIKit/UIKit.h>
@import Charts;
#import "KSasxHTMatchSummaryModel.h"
#import "FFlaliHTMatchLiveFeedModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface KSasxHTScoreViewCell : UITableViewCell

- (void)setMatchSummaryModel:(KSasxHTMatchSummaryModel *)summaryModel liveFeedModel:(NSArray<FFlaliHTMatchLiveFeedModel *> *)liveFeedModel;

@end

NS_ASSUME_NONNULL_END
