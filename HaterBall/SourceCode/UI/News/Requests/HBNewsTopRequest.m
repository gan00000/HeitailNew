#import "HBNewsTopRequest.h"
@implementation HBNewsTopRequest
+ (void)requestWithSuccessBlock:(void(^)(NSArray<HBNewsModel *> *newsList))successBlock
                     errorBlock:(BJServiceErrorBlock)errorBlock {
    [HBBJHTTPServiceEngine getRequestWithFunctionPath:API_NEWS_TOP params:nil successBlock:^(id responseData) {
        NSArray *newsList = [NSArray yy_modelArrayWithClass:[HBNewsModel class] json:responseData[@"posts"]];
        if (successBlock) {
            successBlock(newsList);
        }
    } errorBlock:errorBlock];
}
@end
