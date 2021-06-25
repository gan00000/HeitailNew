#import "UUaksHTNewsBannerRequest.h"
@implementation UUaksHTNewsBannerRequest
+ (void)taorequestWithSuccessBlock:(void(^)(NSArray<UUaksHTNewsModel*> *bannerList))successBlock
                     errorBlock:(BJServiceErrorBlock)errorBlock {
    [BlysaBJHTTPServiceEngine tao_getRequestWithFunctionPath:API_NEWS_BANNER params:nil successBlock:^(id responseData) {
        NSArray *arr = [NSArray yy_modelArrayWithClass:[UUaksHTNewsModel class] json:responseData[@"topslideposts"][@"posts"]];
        if (successBlock) {
            successBlock(arr);
        }
    } errorBlock:errorBlock];
}
@end
