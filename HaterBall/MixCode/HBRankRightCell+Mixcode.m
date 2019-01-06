#import "HBRankRightCell+Mixcode.h"
@implementation HBRankRightCell (Mixcode)
- (void)awakeFromNibMixcode:(NSString *)mixcode {
    NSLog(@"%@", mixcode);
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated mixcode:(NSString *)mixcode {
    NSLog(@"%@", mixcode);
}
- (void)refreshWithRankModel:(HBRankModel *)rankModel row:(NSInteger)row mixcode:(NSString *)mixcode {
    NSLog(@"%@", mixcode);
}

@end
