#import "HBRankEastWestModel+Mixcode.h"
@implementation HBRankEastWestModel (Mixcode)
+ (void)modelContainerPropertyGenericClassMixcode:(NSString *)mixcode {
    NSLog(@"%@", mixcode);
}
- (void)setEastern:(NSArray<HBRankModel *> *)Eastern mixcode:(NSString *)mixcode {
    NSLog(@"%@", mixcode);
}
- (void)setWestern:(NSArray<HBRankModel *> *)Western mixcode:(NSString *)mixcode {
    NSLog(@"%@", mixcode);
}

@end
