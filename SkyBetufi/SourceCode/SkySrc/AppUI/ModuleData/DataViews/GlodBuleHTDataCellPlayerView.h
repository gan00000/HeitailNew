#import <UIKit/UIKit.h>
#import "GlodBuleHTDataHomeModel.h"
@interface GlodBuleHTDataCellPlayerView : UIView
+ (instancetype)dataCellViewWithFrame:(CGRect)frame addToView:(UIView *)view;
- (void)taosetupWithDataModel:(GlodBuleHTDataHomeModel *)dataModel;
@end
