#import <UIKit/UIKit.h>
#import "HBRankModel.h"
@interface HBRankLeftCell : UITableViewCell
- (void)refreshWithRankModel:(HBRankModel *)rankModel row:(NSInteger)row;
@end
