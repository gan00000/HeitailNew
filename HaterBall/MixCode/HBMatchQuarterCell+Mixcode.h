#import <UIKit/UIKit.h>
#import "HBMatchSummaryModel.h"
#import "HBMatchQuarterCell.h"

@interface HBMatchQuarterCell (Mixcode)
- (void)awakeFromNibMixcode:(NSString *)mixcode;
- (void)setSelected:(BOOL)selected animated:(BOOL)animated mixcode:(NSString *)mixcode;
- (void)setupWithMatchSummaryModel:(HBMatchSummaryModel *)summaryModel mixcode:(NSString *)mixcode;
- (void)getLabelAtIndex:(NSInteger)index quarterCount:(NSInteger)count labelWidth:(CGFloat)width mixcode:(NSString *)mixcode;
- (void)labelsMixcode:(NSString *)mixcode;

@end
