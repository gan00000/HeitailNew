#import <Foundation/Foundation.h>
#import "PXFunBJHTTPServiceEngine.h"
#import "SundayHTMatchLiveFeedModel.h"
@interface PXFunHTMatchLiveFeedRequest : NSObject
+ (void)taorequestLiveFeedWithGameId:(NSString *)game_id
                     successBlock:(void(^)(NSArray<SundayHTMatchLiveFeedModel *> *feedList))successBlock
                       errorBlock:(BJServiceErrorBlock)errorBlock;
@end
