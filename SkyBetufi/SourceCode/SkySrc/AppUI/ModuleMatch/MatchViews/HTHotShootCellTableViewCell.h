//
//  HTHotShootCellTableViewCell.h
//  XXXHeiTai
//
//  Created by ganyuanrong on 2021/3/5.
//  Copyright © 2021 Dean_F. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTCourtHotShootView.h"
#import "HotShootPointModel.h"
#import "GlodBuleHTMatchCompareModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HTHotShootCellTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet HTCourtHotShootView *hotShootView;

-(void) updateMatchInfoWiithSummaryModel:(GlodBuleHTMatchSummaryModel *)summaryModel matchCompareModel:(GlodBuleHTMatchCompareModel *)matchCompareModel gameId:(NSString*)gameId;

- (void)updateHotShootDataModel:(NSArray<HotShootPointModel *> *) model isLeft:(BOOL) isLeft width:(CGFloat)width height:(CGFloat)height;

@end

NS_ASSUME_NONNULL_END
