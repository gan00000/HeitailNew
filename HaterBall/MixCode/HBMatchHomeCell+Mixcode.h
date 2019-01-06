#import <UIKit/UIKit.h>
#import "HBMatchHomeModel.h"
#import "HBMatchHomeCell.h"
#import <WebKit/WebKit.h>

@interface HBMatchHomeCell (Mixcode)
- (void)awakeFromNibMixcode:(NSString *)mixcode;
- (void)setSelected:(BOOL)selected animated:(BOOL)animated mixcode:(NSString *)mixcode;
- (void)setupWithMatchModel:(HBMatchHomeModel *)matchModel mixcode:(NSString *)mixcode;
- (void)homeTeamLogoWebMixcode:(NSString *)mixcode;
- (void)awayTeamLogoWebMixcode:(NSString *)mixcode;

@end
