#import <UIKit/UIKit.h>
#import "HBMatchLiveFeedModel.h"
#import "HBMatchLiveFeedCell.h"

@interface HBMatchLiveFeedCell (Mixcode)
- (void)awakeFromNibMixcode:(NSString *)mixcode;
- (void)setSelected:(BOOL)selected animated:(BOOL)animated mixcode:(NSString *)mixcode;
- (void)setupWithMatchLiveFeedModel:(HBMatchLiveFeedModel *)feedModel mixcode:(NSString *)mixcode;

@end
