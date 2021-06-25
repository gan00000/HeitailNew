#import <UIKit/UIKit.h>
#import "BByasHTDataHomeModel.h"
@interface FFlaliHTDataCellPlayerView : UIView
+ (instancetype)dataCellViewWithFrame:(CGRect)frame addToView:(UIView *)view;
- (void)taosetupWithDataModel:(BByasHTDataHomeModel *)dataModel;
@end
