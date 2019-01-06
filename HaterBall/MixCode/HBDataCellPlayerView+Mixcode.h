#import <UIKit/UIKit.h>
#import "HBDataHomeModel.h"
#import "HBDataCellPlayerView.h"
#import <WebKit/WebKit.h>

@interface HBDataCellPlayerView (Mixcode)
+ (void)dataCellViewWithFrame:(CGRect)frame addToView:(UIView *)view mixcode:(NSString *)mixcode;
- (void)setupWithDataModel:(HBDataHomeModel *)dataModel mixcode:(NSString *)mixcode;

@end
