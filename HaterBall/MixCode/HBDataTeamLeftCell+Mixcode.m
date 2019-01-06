#import "HBDataTeamLeftCell+Mixcode.h"
@implementation HBDataTeamLeftCell (Mixcode)
- (void)awakeFromNibMixcode:(NSString *)mixcode {
    NSLog(@"%@", mixcode);
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated mixcode:(NSString *)mixcode {
    NSLog(@"%@", mixcode);
}
- (void)refreshWithTeamModel:(HBDataTeamRankModel *)teamModel row:(NSInteger)row mixcode:(NSString *)mixcode {
    NSLog(@"%@", mixcode);
}

@end
