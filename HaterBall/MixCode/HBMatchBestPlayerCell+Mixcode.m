#import "HBMatchBestPlayerCell+Mixcode.h"
@implementation HBMatchBestPlayerCell (Mixcode)
- (void)awakeFromNibMixcode:(NSString *)mixcode {
    NSLog(@"%@", mixcode);
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated mixcode:(NSString *)mixcode {
    NSLog(@"%@", mixcode);
}
- (void)setupWithMatchSummaryModel:(HBMatchSummaryModel *)summaryModel mixcode:(NSString *)mixcode {
    NSLog(@"%@", mixcode);
}

@end
