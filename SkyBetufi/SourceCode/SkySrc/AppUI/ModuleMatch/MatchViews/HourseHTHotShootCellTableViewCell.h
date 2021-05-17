//
//  HourseHTHotShootCellTableViewCell.h
//  
//
//  Created by ganyuanrong on 2021/3/5.
//  Copyright © 2021 Dean_F. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMTodayHTCourtHotShootView.h"
#import "HourseHotShootPointModel.h"
#import "PXFunHTMatchCompareModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HourseHTHotShootCellTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet MMTodayHTCourtHotShootView *hotShootView;

-(void) updateMatchInfoWiithSummaryModel:(NDeskHTMatchSummaryModel *)summaryModel matchCompareModel:(PXFunHTMatchCompareModel *)matchCompareModel gameId:(NSString*)gameId;

- (void)updateHotShootDataModel:(NSArray<HourseHotShootPointModel *> *) model isLeft:(BOOL) isLeft width:(CGFloat)width height:(CGFloat)height;

@end

NS_ASSUME_NONNULL_END
