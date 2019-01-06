#import <Foundation/Foundation.h>
#import "HBBJHTTPServiceEngine.h"
#import "HBRankEastWestModel.h"
@interface HBRankEastWestRequest : NSObject
+ (void)requestWithSuccessBlock:(void(^)(HBRankEastWestModel *eastWestModel))successBlock
                     errorBlock:(BJServiceErrorBlock)errorBlock;
@end
