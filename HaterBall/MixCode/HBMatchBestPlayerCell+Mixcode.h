#import <UIKit/UIKit.h>
#import "HBMatchSummaryModel.h"
#import "HBMatchBestPlayerCell.h"

@interface HBMatchBestPlayerCell (Mixcode)
- (void)awakeFromNibMixcode:(NSString *)mixcode;
- (void)setSelected:(BOOL)selected animated:(BOOL)animated mixcode:(NSString *)mixcode;
- (void)setupWithMatchSummaryModel:(HBMatchSummaryModel *)summaryModel mixcode:(NSString *)mixcode;

@end
