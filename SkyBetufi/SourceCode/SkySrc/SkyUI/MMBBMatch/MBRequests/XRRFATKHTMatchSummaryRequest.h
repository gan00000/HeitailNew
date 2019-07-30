#import <Foundation/Foundation.h>
#import "XRRFATKBJHTTPServiceEngine.h"
#import "XRRFATKHTMatchSummaryModel.h"
#import "XRRFATKHTMatchCompareModel.h"
@interface XRRFATKHTMatchSummaryRequest : NSObject
+ (void)skargrequestSummaryWithGameId:(NSString *)game_id
                    successBlock:(void(^)(XRRFATKHTMatchSummaryModel *summaryModel, XRRFATKHTMatchCompareModel *compareModel))successBlock
                      errorBlock:(BJServiceErrorBlock)errorBlock;
@end
