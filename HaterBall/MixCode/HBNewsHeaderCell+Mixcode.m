#import "HBNewsHeaderCell+Mixcode.h"
@implementation HBNewsHeaderCell (Mixcode)
- (void)awakeFromNibMixcode:(NSString *)mixcode {
    NSLog(@"%@", mixcode);
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated mixcode:(NSString *)mixcode {
    NSLog(@"%@", mixcode);
}
- (void)setupWithNewsModel:(HBNewsModel *)newsModel mixcode:(NSString *)mixcode {
    NSLog(@"%@", mixcode);
}

@end
