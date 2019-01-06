#import <UIKit/UIKit.h>
#import "HBMatchSummaryModel.h"
#import "HBMatchPtsCompareCell.h"

@interface HBMatchPtsCompareCell (Mixcode)
- (void)awakeFromNibMixcode:(NSString *)mixcode;
- (void)setSelected:(BOOL)selected animated:(BOOL)animated mixcode:(NSString *)mixcode;
- (void)setupWithMatchSummaryModel:(HBMatchSummaryModel *)summaryModel mixcode:(NSString *)mixcode;

@end
