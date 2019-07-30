#import <UIKit/UIKit.h>
#import "XRRFATKHTDataHomeModel.h"
@interface XRRFATKHTDataCellTeamView : UIView
+ (instancetype)dataCellViewWithFrame:(CGRect)frame addToView:(UIView *)view;
- (void)skargsetupWithDataModel:(XRRFATKHTDataHomeModel *)dataModel;
@end
