#import <UIKit/UIKit.h>
#import "BByasHTDataHomeModel.h"
@interface CfipyHTDataCellTeamView : UIView
+ (instancetype)dataCellViewWithFrame:(CGRect)frame addToView:(UIView *)view;
- (void)taosetupWithDataModel:(BByasHTDataHomeModel *)dataModel;
@end
