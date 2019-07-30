#import <Foundation/Foundation.h>
#import "XRRFATKBJHTTPServiceEngine.h"
#import "XRRFATKHTNewsModel.h"
@interface XRRFATKHTNewsBannerRequest : NSObject
+ (void)skargrequestWithSuccessBlock:(void(^)(NSArray<XRRFATKHTNewsModel*> *bannerList))successBlock
                     errorBlock:(BJServiceErrorBlock)errorBlock;
@end
