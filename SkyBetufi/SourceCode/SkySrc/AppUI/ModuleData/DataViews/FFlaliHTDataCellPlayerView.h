#import <UIKit/UIKit.h>
#import "NSNiceHTDataHomeModel.h"
@interface FFlaliHTDataCellPlayerView : UIView
+ (instancetype)dataCellViewWithFrame:(CGRect)frame addToView:(UIView *)view;
- (void)taosetupWithDataModel:(NSNiceHTDataHomeModel *)dataModel;
@end
