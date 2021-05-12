#import <UIKit/UIKit.h>
#import "PXFunHTDataHomeModel.h"
@interface CCCaseHTDataCellTeamView : UIView
+ (instancetype)dataCellViewWithFrame:(CGRect)frame addToView:(UIView *)view;
- (void)taosetupWithDataModel:(PXFunHTDataHomeModel *)dataModel;
@end
