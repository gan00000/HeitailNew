#import <Foundation/Foundation.h>
#import "PXFunBJHTTPServiceEngine.h"
#import "PXFunHTNewsModel.h"
@interface GGCatHTNewsBannerRequest : NSObject
+ (void)taorequestWithSuccessBlock:(void(^)(NSArray<PXFunHTNewsModel*> *bannerList))successBlock
                     errorBlock:(BJServiceErrorBlock)errorBlock;
@end
