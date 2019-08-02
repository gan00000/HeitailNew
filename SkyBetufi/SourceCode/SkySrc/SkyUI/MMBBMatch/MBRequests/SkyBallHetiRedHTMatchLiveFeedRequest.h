#import <Foundation/Foundation.h>
#import "SkyBallHetiRedBJHTTPServiceEngine.h"
#import "SkyBallHetiRedHTMatchLiveFeedModel.h"
@interface SkyBallHetiRedHTMatchLiveFeedRequest : NSObject
+ (void)waterSkyrequestLiveFeedWithGameId:(NSString *)game_id
                     successBlock:(void(^)(NSArray<SkyBallHetiRedHTMatchLiveFeedModel *> *feedList))successBlock
                       errorBlock:(BJServiceErrorBlock)errorBlock;
@end
