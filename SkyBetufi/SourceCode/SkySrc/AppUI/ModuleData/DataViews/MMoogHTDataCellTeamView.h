#import <UIKit/UIKit.h>
#import "NSNiceHTDataHomeModel.h"
@interface MMoogHTDataCellTeamView : UIView
+ (instancetype)dataCellViewWithFrame:(CGRect)frame addToView:(UIView *)view;
- (void)taosetupWithDataModel:(NSNiceHTDataHomeModel *)dataModel;
@end
