#import <UIKit/UIKit.h>
#import "HBRankModel.h"
#import "HBRankRightCell.h"

@interface HBRankRightCell (Mixcode)
- (void)awakeFromNibMixcode:(NSString *)mixcode;
- (void)setSelected:(BOOL)selected animated:(BOOL)animated mixcode:(NSString *)mixcode;
- (void)refreshWithRankModel:(HBRankModel *)rankModel row:(NSInteger)row mixcode:(NSString *)mixcode;

@end
