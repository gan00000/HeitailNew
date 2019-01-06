#import <UIKit/UIKit.h>
#import "HBDataTeamRankModel.h"
#import "HBDataTeamLeftCell.h"

@interface HBDataTeamLeftCell (Mixcode)
- (void)awakeFromNibMixcode:(NSString *)mixcode;
- (void)setSelected:(BOOL)selected animated:(BOOL)animated mixcode:(NSString *)mixcode;
- (void)refreshWithTeamModel:(HBDataTeamRankModel *)teamModel row:(NSInteger)row mixcode:(NSString *)mixcode;

@end
