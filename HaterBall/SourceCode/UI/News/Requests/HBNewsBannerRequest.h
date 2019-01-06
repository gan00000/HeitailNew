#import <Foundation/Foundation.h>
#import "HBBJHTTPServiceEngine.h"
#import "HBNewsModel.h"
@interface HBNewsBannerRequest : NSObject
+ (void)requestWithSuccessBlock:(void(^)(NSArray<HBNewsModel*> *bannerList))successBlock
                     errorBlock:(BJServiceErrorBlock)errorBlock;
@end
