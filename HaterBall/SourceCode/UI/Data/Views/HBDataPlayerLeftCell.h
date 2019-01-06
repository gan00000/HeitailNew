#import <UIKit/UIKit.h>
#import "HBDataPlayerRankModel.h"
@interface HBDataPlayerLeftCell : UITableViewCell
- (void)refreshWithPlayerModel:(HBDataPlayerRankModel *)playerModel row:(NSInteger)row;
@end
