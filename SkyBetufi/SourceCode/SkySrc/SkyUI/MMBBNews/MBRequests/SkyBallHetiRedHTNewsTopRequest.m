#import "SkyBallHetiRedHTNewsTopRequest.h"
@implementation SkyBallHetiRedHTNewsTopRequest
+ (void)waterSkyrequestWithSuccessBlock:(void(^)(NSArray<SkyBallHetiRedHTNewsModel *> *newsList))successBlock
                     errorBlock:(BJServiceErrorBlock)errorBlock {
    [SkyBallHetiRedBJHTTPServiceEngine waterSky_getRequestWithFunctionPath:API_NEWS_TOP params:nil successBlock:^(id responseData) {
        NSArray *newsList = [NSArray yy_modelArrayWithClass:[SkyBallHetiRedHTNewsModel class] json:responseData[@"posts"]];
        if (successBlock) {
            successBlock(newsList);
        }
    } errorBlock:errorBlock];
}
@end
