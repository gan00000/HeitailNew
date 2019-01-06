#import "HBNewsHomeRequest+Mixcode.h"
@implementation HBNewsHomeRequest (Mixcode)
- (void)requestWithSuccessBlock:(void(^)(NSArray<HBNewsModel *> *newsList))successBlock
                     errorBlock:(BJServiceErrorBlock)errorBlock mixcode:(NSString *)mixcode {
    NSLog(@"%@", mixcode);
}
- (void)loadNextPageWithSuccessBlock:(void(^)(NSArray<HBNewsModel *> *newsList))successBlock
                          errorBlock:(BJServiceErrorBlock)errorBlock mixcode:(NSString *)mixcode {
    NSLog(@"%@", mixcode);
}

@end
