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

-(void) updateDataModel:(NSArray<HotShootPointModel *> *) model  summaryModel:(GlodBuleHTMatchSummaryModel *)summaryModel matchCompareModel:(GlodBuleHTMatchCompareModel *)matchCompareModel gameId:(NSString*)gameId isLeft:(BOOL) isLeft;

- (void)setDataModel:(NSArray<HotShootPointModel *> *) model isLeft:(BOOL) isLeft width:(CGFloat)width height:(CGFloat)height;

@end

NS_ASSUME_NONNULL_END
