#import "GlodBuleHTNewsBannerRequest.h"
@implementation GlodBuleHTNewsBannerRequest
+ (void)waterSkyrequestWithSuccessBlock:(void(^)(NSArray<GlodBuleHTNewsModel*> *bannerList))successBlock
                     errorBlock:(BJServiceErrorBlock)errorBlock {
    [GlodBuleBJHTTPServiceEngine waterSky_getRequestWithFunctionPath:API_NEWS_BANNER params:nil successBlock:^(id responseData) {
        NSArray *arr = [NSArray yy_modelArrayWithClass:[GlodBuleHTNewsModel class] json:responseData[@"topslideposts"][@"posts"]];
        if (successBlock) {
            successBlock(arr);
        }
    } errorBlock:errorBlock];
}
@end
