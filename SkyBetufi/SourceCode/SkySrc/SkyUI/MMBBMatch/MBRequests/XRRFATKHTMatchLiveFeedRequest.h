#import <Foundation/Foundation.h>
#import "XRRFATKBJHTTPServiceEngine.h"
#import "XRRFATKHTMatchLiveFeedModel.h"
@interface XRRFATKHTMatchLiveFeedRequest : NSObject
+ (void)skargrequestLiveFeedWithGameId:(NSString *)game_id
                     successBlock:(void(^)(NSArray<XRRFATKHTMatchLiveFeedModel *> *feedList))successBlock
                       errorBlock:(BJServiceErrorBlock)errorBlock;
@end
