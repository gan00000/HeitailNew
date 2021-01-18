#import <Foundation/Foundation.h>
#import "GlodBuleBJHTTPServiceEngine.h"
#import "GlodBuleHTMatchLiveFeedModel.h"
@interface GlodBuleHTMatchLiveFeedRequest : NSObject
+ (void)waterSkyrequestLiveFeedWithGameId:(NSString *)game_id
                     successBlock:(void(^)(NSArray<GlodBuleHTMatchLiveFeedModel *> *feedList))successBlock
                       errorBlock:(BJServiceErrorBlock)errorBlock;
@end
