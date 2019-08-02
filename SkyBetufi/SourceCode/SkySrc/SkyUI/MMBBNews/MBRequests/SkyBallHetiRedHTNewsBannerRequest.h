#import <Foundation/Foundation.h>
#import "SkyBallHetiRedBJHTTPServiceEngine.h"
#import "SkyBallHetiRedHTNewsModel.h"
@interface SkyBallHetiRedHTNewsBannerRequest : NSObject
+ (void)waterSkyrequestWithSuccessBlock:(void(^)(NSArray<SkyBallHetiRedHTNewsModel*> *bannerList))successBlock
                     errorBlock:(BJServiceErrorBlock)errorBlock;
@end
