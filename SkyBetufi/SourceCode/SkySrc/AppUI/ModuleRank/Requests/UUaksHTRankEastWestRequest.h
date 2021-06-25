#import <Foundation/Foundation.h>
#import "NSNiceBJHTTPServiceEngine.h"
#import "BByasHTRankEastWestModel.h"
@interface UUaksHTRankEastWestRequest : NSObject
+ (void)taorequestWithSuccessBlock:(void(^)(BByasHTRankEastWestModel *eastWestModel))successBlock
                     errorBlock:(BJServiceErrorBlock)errorBlock;
@end
