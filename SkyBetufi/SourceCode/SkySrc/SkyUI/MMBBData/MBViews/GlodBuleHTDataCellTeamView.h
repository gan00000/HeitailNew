#import <UIKit/UIKit.h>
#import "GlodBuleHTDataHomeModel.h"
@interface GlodBuleHTDataCellTeamView : UIView
+ (instancetype)dataCellViewWithFrame:(CGRect)frame addToView:(UIView *)view;
- (void)waterSkysetupWithDataModel:(GlodBuleHTDataHomeModel *)dataModel;
@end
