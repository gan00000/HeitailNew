#import "HBNewsTopRequest+Mixcode.h"
@implementation HBNewsTopRequest (Mixcode)
+ (void)requestWithSuccessBlock:(void(^)(NSArray<HBNewsModel *> *newsList))successBlock
                     errorBlock:(BJServiceErrorBlock)errorBlock mixcode:(NSString *)mixcode {
    NSLog(@"%@", mixcode);
}

@end
