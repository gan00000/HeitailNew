#import <Foundation/Foundation.h>
#import "PXFunBJHTTPServiceEngine.h"
#import "HourseHTRankEastWestModel.h"
@interface HourseHTRankEastWestRequest : NSObject
+ (void)taorequestWithSuccessBlock:(void(^)(HourseHTRankEastWestModel *eastWestModel))successBlock
                     errorBlock:(BJServiceErrorBlock)errorBlock;
@end
