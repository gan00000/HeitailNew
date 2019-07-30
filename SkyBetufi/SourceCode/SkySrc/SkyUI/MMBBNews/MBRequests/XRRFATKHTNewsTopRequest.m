#import "XRRFATKHTNewsTopRequest.h"
@implementation XRRFATKHTNewsTopRequest
+ (void)skargrequestWithSuccessBlock:(void(^)(NSArray<XRRFATKHTNewsModel *> *newsList))successBlock
                     errorBlock:(BJServiceErrorBlock)errorBlock {
    [XRRFATKBJHTTPServiceEngine skarg_getRequestWithFunctionPath:API_NEWS_TOP params:nil successBlock:^(id responseData) {
        NSArray *newsList = [NSArray yy_modelArrayWithClass:[XRRFATKHTNewsModel class] json:responseData[@"posts"]];
        if (successBlock) {
            successBlock(newsList);
        }
    } errorBlock:errorBlock];
}
@end
