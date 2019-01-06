#import "HBNewsBannerRequest+Mixcode.h"
@implementation HBNewsBannerRequest (Mixcode)
+ (void)requestWithSuccessBlock:(void(^)(NSArray<HBNewsModel*> *bannerList))successBlock
                     errorBlock:(BJServiceErrorBlock)errorBlock mixcode:(NSString *)mixcode {
    NSLog(@"%@", mixcode);
}

@end
