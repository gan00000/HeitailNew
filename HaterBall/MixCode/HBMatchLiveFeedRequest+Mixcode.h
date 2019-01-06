#import <Foundation/Foundation.h>
#import "HBBJHTTPServiceEngine.h"
#import "HBMatchLiveFeedModel.h"
#import "HBMatchLiveFeedRequest.h"

@interface HBMatchLiveFeedRequest (Mixcode)
+ (void)requestLiveFeedWithGameId:(NSString *)game_id
                     successBlock:(void(^)(NSArray<HBMatchLiveFeedModel *> *feedList))successBlock
                       errorBlock:(BJServiceErrorBlock)errorBlock mixcode:(NSString *)mixcode;

@end
