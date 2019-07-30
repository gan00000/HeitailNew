#import <Foundation/Foundation.h>
#import "XRRFATKBJHTTPServiceEngine.h"
#import "XRRFATKHTRankEastWestModel.h"
@interface XRRFATKHTRankEastWestRequest : NSObject
+ (void)skargrequestWithSuccessBlock:(void(^)(XRRFATKHTRankEastWestModel *eastWestModel))successBlock
                     errorBlock:(BJServiceErrorBlock)errorBlock;
@end
