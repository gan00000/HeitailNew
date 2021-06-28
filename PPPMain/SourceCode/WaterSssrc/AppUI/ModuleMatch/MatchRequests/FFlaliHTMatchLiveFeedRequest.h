#import <Foundation/Foundation.h>
#import "NSNiceBJHTTPServiceEngine.h"
#import "FFlaliHTMatchLiveFeedModel.h"
@interface FFlaliHTMatchLiveFeedRequest : NSObject
+ (void)taorequestLiveFeedWithGameId:(NSString *)game_id
                     successBlock:(void(^)(NSArray<FFlaliHTMatchLiveFeedModel *> *feedList))successBlock
                       errorBlock:(BJServiceErrorBlock)errorBlock;
@end
