#import <UIKit/UIKit.h>
#import "HBDataPlayerRankModel.h"
#import "HBDataPlayerRightCell.h"

@interface HBDataPlayerRightCell (Mixcode)
- (void)awakeFromNibMixcode:(NSString *)mixcode;
- (void)setSelected:(BOOL)selected animated:(BOOL)animated mixcode:(NSString *)mixcode;
- (void)refreshWithPlayerModel:(HBDataPlayerRankModel *)playerModel row:(NSInteger)row mixcode:(NSString *)mixcode;

@end
