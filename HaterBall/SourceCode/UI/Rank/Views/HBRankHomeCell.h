#import <UIKit/UIKit.h>
#import "HBRankModel.h"
@interface HBRankHomeCell : UITableViewCell
- (void)setupWithTitle:(NSString *)title rankList:(NSArray<HBRankModel *> *)rankList;
@end
