#import <Foundation/Foundation.h>
#import "GlodBuleBJHTTPServiceEngine.h"
#import "GlodBuleHTRankEastWestModel.h"
@interface GlodBuleHTRankEastWestRequest : NSObject
+ (void)taorequestWithSuccessBlock:(void(^)(GlodBuleHTRankEastWestModel *eastWestModel))successBlock
                     errorBlock:(BJServiceErrorBlock)errorBlock;
@end
