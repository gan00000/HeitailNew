#import "XRRFATKHTNewsBannerRequest.h"
@implementation XRRFATKHTNewsBannerRequest
+ (void)skargrequestWithSuccessBlock:(void(^)(NSArray<XRRFATKHTNewsModel*> *bannerList))successBlock
                     errorBlock:(BJServiceErrorBlock)errorBlock {
    [XRRFATKBJHTTPServiceEngine skarg_getRequestWithFunctionPath:API_NEWS_BANNER params:nil successBlock:^(id responseData) {
        NSArray *arr = [NSArray yy_modelArrayWithClass:[XRRFATKHTNewsModel class] json:responseData[@"topslideposts"][@"posts"]];
        if (successBlock) {
            successBlock(arr);
        }
    } errorBlock:errorBlock];
}
@end
