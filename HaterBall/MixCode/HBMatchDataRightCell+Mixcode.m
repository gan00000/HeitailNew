#import "HBMatchDataRightCell+Mixcode.h"
@implementation HBMatchDataRightCell (Mixcode)
- (void)awakeFromNibMixcode:(NSString *)mixcode {
    NSLog(@"%@", mixcode);
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated mixcode:(NSString *)mixcode {
    NSLog(@"%@", mixcode);
}
- (void)refreshWithModel:(HBMatchDetailsModel *)model row:(NSInteger)row mixcode:(NSString *)mixcode {
    NSLog(@"%@", mixcode);
}

@end
