#import <UIKit/UIKit.h>
#import "HBMatchDetailsModel.h"
#import "HBMatchDataRightCell.h"

@interface HBMatchDataRightCell (Mixcode)
- (void)awakeFromNibMixcode:(NSString *)mixcode;
- (void)setSelected:(BOOL)selected animated:(BOOL)animated mixcode:(NSString *)mixcode;
- (void)refreshWithModel:(HBMatchDetailsModel *)model row:(NSInteger)row mixcode:(NSString *)mixcode;

@end
