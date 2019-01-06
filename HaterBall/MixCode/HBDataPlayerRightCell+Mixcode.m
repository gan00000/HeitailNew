#import "HBDataPlayerRightCell+Mixcode.h"
@implementation HBDataPlayerRightCell (Mixcode)
- (void)awakeFromNibMixcode:(NSString *)mixcode {
    NSLog(@"%@", mixcode);
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated mixcode:(NSString *)mixcode {
    NSLog(@"%@", mixcode);
}
- (void)refreshWithPlayerModel:(HBDataPlayerRankModel *)playerModel row:(NSInteger)row mixcode:(NSString *)mixcode {
    NSLog(@"%@", mixcode);
}

@end
