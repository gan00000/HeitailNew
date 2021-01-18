#import "GlodBuleHTNewsTopRequest.h"
@implementation GlodBuleHTNewsTopRequest
+ (void)waterSkyrequestWithSuccessBlock:(void(^)(NSArray<GlodBuleHTNewsModel *> *newsList))successBlock
                     errorBlock:(BJServiceErrorBlock)errorBlock {
    [GlodBuleBJHTTPServiceEngine waterSky_getRequestWithFunctionPath:API_NEWS_TOP params:nil successBlock:^(id responseData) {
        NSArray *newsList = [NSArray yy_modelArrayWithClass:[GlodBuleHTNewsModel class] json:responseData[@"posts"]];
        if (successBlock) {
            successBlock(newsList);
        }
    } errorBlock:errorBlock];
}
@end
