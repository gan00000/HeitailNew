#import <Foundation/Foundation.h>
#import "HBBJHTTPServiceEngine.h"
#import "HBNewsModel.h"
#import "HBNewsBannerRequest.h"

@interface HBNewsBannerRequest (Mixcode)
+ (void)requestWithSuccessBlock:(void(^)(NSArray<HBNewsModel*> *bannerList))successBlock
                     errorBlock:(BJServiceErrorBlock)errorBlock mixcode:(NSString *)mixcode;

@end
