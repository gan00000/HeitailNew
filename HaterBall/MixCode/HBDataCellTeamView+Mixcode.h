#import <UIKit/UIKit.h>
#import "HBDataHomeModel.h"
#import "HBDataCellTeamView.h"
#import <WebKit/WebKit.h>

@interface HBDataCellTeamView (Mixcode)
+ (void)dataCellViewWithFrame:(CGRect)frame addToView:(UIView *)view mixcode:(NSString *)mixcode;
- (void)awakeFromNibMixcode:(NSString *)mixcode;
- (void)setupWithDataModel:(HBDataHomeModel *)dataModel mixcode:(NSString *)mixcode;
- (void)teamLogoWebMixcode:(NSString *)mixcode;

@end
