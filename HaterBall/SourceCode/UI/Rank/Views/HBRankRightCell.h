#import <UIKit/UIKit.h>
#import "HBRankModel.h"
@interface HBRankRightCell : UITableViewCell
- (void)refreshWithRankModel:(HBRankModel *)rankModel row:(NSInteger)row;
@end
