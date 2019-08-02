#import <Foundation/Foundation.h>
#import "SkyBallHetiRedBJHTTPServiceEngine.h"
#import "SkyBallHetiRedHTRankEastWestModel.h"
@interface SkyBallHetiRedHTRankEastWestRequest : NSObject
+ (void)waterSkyrequestWithSuccessBlock:(void(^)(SkyBallHetiRedHTRankEastWestModel *eastWestModel))successBlock
                     errorBlock:(BJServiceErrorBlock)errorBlock;
@end
