#import "HBMatchLiveFeedRequest+Mixcode.h"
@implementation HBMatchLiveFeedRequest (Mixcode)
+ (void)requestLiveFeedWithGameId:(NSString *)game_id
                     successBlock:(void(^)(NSArray<HBMatchLiveFeedModel *> *feedList))successBlock
                       errorBlock:(BJServiceErrorBlock)errorBlock mixcode:(NSString *)mixcode {
    NSLog(@"%@", mixcode);
}

@end
