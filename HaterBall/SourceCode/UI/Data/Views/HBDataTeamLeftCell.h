#import <UIKit/UIKit.h>
#import "HBDataTeamRankModel.h"
@interface HBDataTeamLeftCell : UITableViewCell
- (void)refreshWithTeamModel:(HBDataTeamRankModel *)teamModel row:(NSInteger)row;
@end
