#import <UIKit/UIKit.h>
#import "HBDataPlayerRankModel.h"
#import "HBDataPlayerLeftCell.h"

@interface HBDataPlayerLeftCell (Mixcode)
- (void)awakeFromNibMixcode:(NSString *)mixcode;
- (void)setSelected:(BOOL)selected animated:(BOOL)animated mixcode:(NSString *)mixcode;
- (void)refreshWithPlayerModel:(HBDataPlayerRankModel *)playerModel row:(NSInteger)row mixcode:(NSString *)mixcode;

@end
