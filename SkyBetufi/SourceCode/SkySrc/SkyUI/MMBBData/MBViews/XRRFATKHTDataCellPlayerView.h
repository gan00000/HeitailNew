#import <UIKit/UIKit.h>
#import "XRRFATKHTDataHomeModel.h"
@interface XRRFATKHTDataCellPlayerView : UIView
+ (instancetype)dataCellViewWithFrame:(CGRect)frame addToView:(UIView *)view;
- (void)skargsetupWithDataModel:(XRRFATKHTDataHomeModel *)dataModel;
@end
