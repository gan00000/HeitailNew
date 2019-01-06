#import <Foundation/Foundation.h>
#import "HBBJHTTPServiceEngine.h"
#import "HBMatchLiveFeedModel.h"
@interface HBMatchLiveFeedRequest : NSObject
+ (void)requestLiveFeedWithGameId:(NSString *)game_id
                     successBlock:(void(^)(NSArray<HBMatchLiveFeedModel *> *feedList))successBlock
                       errorBlock:(BJServiceErrorBlock)errorBlock;
@end
