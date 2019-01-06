#import "HBRankEastWestRequest+Mixcode.h"
@implementation HBRankEastWestRequest (Mixcode)
+ (void)requestWithSuccessBlock:(void(^)(HBRankEastWestModel *eastWestModel))successBlock
                     errorBlock:(BJServiceErrorBlock)errorBlock mixcode:(NSString *)mixcode {
    NSLog(@"%@", mixcode);
}

@end
