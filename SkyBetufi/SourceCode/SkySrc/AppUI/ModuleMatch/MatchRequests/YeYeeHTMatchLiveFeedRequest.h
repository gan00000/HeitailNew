#import <Foundation/Foundation.h>
#import "BlysaBJHTTPServiceEngine.h"
#import "UUaksHTMatchLiveFeedModel.h"
@interface YeYeeHTMatchLiveFeedRequest : NSObject
+ (void)taorequestLiveFeedWithGameId:(NSString *)game_id
                     successBlock:(void(^)(NSArray<UUaksHTMatchLiveFeedModel *> *feedList))successBlock
                       errorBlock:(BJServiceErrorBlock)errorBlock;
@end
