#import <UIKit/UIKit.h>
#import "HBDataHomeModel.h"
@interface HBDataCellPlayerView : UIView
+ (instancetype)dataCellViewWithFrame:(CGRect)frame addToView:(UIView *)view;
- (void)setupWithDataModel:(HBDataHomeModel *)dataModel;
@end
