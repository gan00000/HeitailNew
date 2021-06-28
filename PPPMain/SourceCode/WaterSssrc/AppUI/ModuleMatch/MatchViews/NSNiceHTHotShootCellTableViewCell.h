//
//  NSNiceHTHotShootCellTableViewCell.h
//  
//
//  Created by ganyuanrong on 2021/3/5.
//  Copyright © 2021 Dean_F. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YeYeeHTCourtHotShootView.h"
#import "TuTuosHotShootPointModel.h"
#import "BByasHTMatchCompareModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSNiceHTHotShootCellTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet YeYeeHTCourtHotShootView *hotShootView;

-(void) updateMatchInfoWiithSummaryModel:(KSasxHTMatchSummaryModel *)summaryModel matchCompareModel:(BByasHTMatchCompareModel *)matchCompareModel gameId:(NSString*)gameId;

- (void)updateHotShootDataModel:(NSArray<TuTuosHotShootPointModel *> *) model isLeft:(BOOL) isLeft width:(CGFloat)width height:(CGFloat)height;

@end

NS_ASSUME_NONNULL_END
