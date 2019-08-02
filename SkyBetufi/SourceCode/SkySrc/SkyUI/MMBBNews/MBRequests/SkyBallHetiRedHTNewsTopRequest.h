#import <Foundation/Foundation.h>
#import "SkyBallHetiRedBJHTTPServiceEngine.h"
#import "SkyBallHetiRedHTNewsModel.h"
@interface SkyBallHetiRedHTNewsTopRequest : NSObject
+ (void)waterSkyrequestWithSuccessBlock:(void(^)(NSArray<SkyBallHetiRedHTNewsModel *> *newsList))successBlock
                     errorBlock:(BJServiceErrorBlock)errorBlock;
@end
