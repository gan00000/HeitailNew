#import <UIKit/UIKit.h>
#import "SkyBallHetiRedHTDataHomeModel.h"
@interface SkyBallHetiRedHTDataCellPlayerView : UIView
+ (instancetype)dataCellViewWithFrame:(CGRect)frame addToView:(UIView *)view;
- (void)waterSkysetupWithDataModel:(SkyBallHetiRedHTDataHomeModel *)dataModel;
@end
