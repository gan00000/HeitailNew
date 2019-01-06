#import <Foundation/Foundation.h>
#import "HBBJHTTPServiceEngine.h"
#import "HBRankEastWestModel.h"
#import "HBRankEastWestRequest.h"

@interface HBRankEastWestRequest (Mixcode)
+ (void)requestWithSuccessBlock:(void(^)(HBRankEastWestModel *eastWestModel))successBlock
                     errorBlock:(BJServiceErrorBlock)errorBlock mixcode:(NSString *)mixcode;

@end
