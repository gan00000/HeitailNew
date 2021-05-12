#import "KMonkeyHTNewsTopRequest.h"
@implementation KMonkeyHTNewsTopRequest
+ (void)taorequestWithSuccessBlock:(void(^)(NSArray<PXFunHTNewsModel *> *newsList))successBlock
                     errorBlock:(BJServiceErrorBlock)errorBlock {
    [PXFunBJHTTPServiceEngine tao_getRequestWithFunctionPath:API_NEWS_TOP params:nil successBlock:^(id responseData) {
        NSArray *newsList = [NSArray yy_modelArrayWithClass:[PXFunHTNewsModel class] json:responseData[@"posts"]];
        if (successBlock) {
            successBlock(newsList);
        }
    } errorBlock:errorBlock];
}
@end
