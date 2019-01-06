#import "HBMatchLiveFeedCell+Mixcode.h"
@implementation HBMatchLiveFeedCell (Mixcode)
- (void)awakeFromNibMixcode:(NSString *)mixcode {
    NSLog(@"%@", mixcode);
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated mixcode:(NSString *)mixcode {
    NSLog(@"%@", mixcode);
}
- (void)setupWithMatchLiveFeedModel:(HBMatchLiveFeedModel *)feedModel mixcode:(NSString *)mixcode {
    NSLog(@"%@", mixcode);
}

@end
