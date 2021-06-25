#import <Foundation/Foundation.h>
#import "BlysaBJHTTPServiceEngine.h"
#import "BByasHTRankEastWestModel.h"
@interface BByasHTRankEastWestRequest : NSObject
+ (void)taorequestWithSuccessBlock:(void(^)(BByasHTRankEastWestModel *eastWestModel))successBlock
                     errorBlock:(BJServiceErrorBlock)errorBlock;
@end
