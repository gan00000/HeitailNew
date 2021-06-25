#import <Foundation/Foundation.h>
#import "NSNiceBJHTTPServiceEngine.h"
#import "CfipyHTNewsModel.h"
@interface KSasxHTNewsBannerRequest : NSObject
+ (void)taorequestWithSuccessBlock:(void(^)(NSArray<CfipyHTNewsModel*> *bannerList))successBlock
                     errorBlock:(BJServiceErrorBlock)errorBlock;
@end
