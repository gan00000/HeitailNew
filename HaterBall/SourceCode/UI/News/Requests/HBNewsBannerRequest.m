#import "HBNewsBannerRequest.h"
@implementation HBNewsBannerRequest
+ (void)requestWithSuccessBlock:(void(^)(NSArray<HBNewsModel*> *bannerList))successBlock
                     errorBlock:(BJServiceErrorBlock)errorBlock {
    [HBBJHTTPServiceEngine getRequestWithFunctionPath:API_NEWS_BANNER params:nil successBlock:^(id responseData) {
        NSArray *arr = [NSArray yy_modelArrayWithClass:[HBNewsModel class] json:responseData[@"topslideposts"][@"posts"]];
        if (successBlock) {
            successBlock(arr);
        }
    } errorBlock:errorBlock];
}
@end
