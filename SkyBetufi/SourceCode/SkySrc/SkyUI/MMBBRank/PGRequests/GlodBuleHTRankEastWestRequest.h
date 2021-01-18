#import <Foundation/Foundation.h>
#import "GlodBuleBJHTTPServiceEngine.h"
#import "GlodBuleHTRankEastWestModel.h"
@interface GlodBuleHTRankEastWestRequest : NSObject
+ (void)waterSkyrequestWithSuccessBlock:(void(^)(GlodBuleHTRankEastWestModel *eastWestModel))successBlock
                     errorBlock:(BJServiceErrorBlock)errorBlock;
@end
