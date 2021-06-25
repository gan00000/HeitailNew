#import "WSKggHTNewsTopRequest.h"
@implementation WSKggHTNewsTopRequest
+ (void)taorequestWithSuccessBlock:(void(^)(NSArray<UUaksHTNewsModel *> *newsList))successBlock
                     errorBlock:(BJServiceErrorBlock)errorBlock {
    [BlysaBJHTTPServiceEngine tao_getRequestWithFunctionPath:API_NEWS_TOP params:nil successBlock:^(id responseData) {
        NSArray *newsList = [NSArray yy_modelArrayWithClass:[UUaksHTNewsModel class] json:responseData[@"posts"]];
        if (successBlock) {
            successBlock(newsList);
        }
    } errorBlock:errorBlock];
}
@end
