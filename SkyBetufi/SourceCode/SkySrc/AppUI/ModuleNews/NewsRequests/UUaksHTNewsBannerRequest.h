#import <Foundation/Foundation.h>
#import "BlysaBJHTTPServiceEngine.h"
#import "UUaksHTNewsModel.h"
@interface UUaksHTNewsBannerRequest : NSObject
+ (void)taorequestWithSuccessBlock:(void(^)(NSArray<UUaksHTNewsModel*> *bannerList))successBlock
                     errorBlock:(BJServiceErrorBlock)errorBlock;
@end
