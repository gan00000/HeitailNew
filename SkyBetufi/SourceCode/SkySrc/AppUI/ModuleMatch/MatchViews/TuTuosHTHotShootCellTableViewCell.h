//
//  TuTuosHTHotShootCellTableViewCell.h
//  
//
//  Created by ganyuanrong on 2021/3/5.
//  Copyright © 2021 Dean_F. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMoogHTCourtHotShootView.h"
#import "BByasHotShootPointModel.h"
#import "WSKggHTMatchCompareModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TuTuosHTHotShootCellTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet MMoogHTCourtHotShootView *hotShootView;

-(void) updateMatchInfoWiithSummaryModel:(NSNiceHTMatchSummaryModel *)summaryModel matchCompareModel:(WSKggHTMatchCompareModel *)matchCompareModel gameId:(NSString*)gameId;

- (void)updateHotShootDataModel:(NSArray<BByasHotShootPointModel *> *) model isLeft:(BOOL) isLeft width:(CGFloat)width height:(CGFloat)height;

@end

NS_ASSUME_NONNULL_END
