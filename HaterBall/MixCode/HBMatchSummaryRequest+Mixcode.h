#import <Foundation/Foundation.h>
#import "HBBJHTTPServiceEngine.h"
#import "HBMatchSummaryModel.h"
#import "HBMatchCompareModel.h"
#import "HBMatchSummaryRequest.h"

@interface HBMatchSummaryRequest (Mixcode)
+ (void)requestSummaryWithGameId:(NSString *)game_id
                    successBlock:(void(^)(HBMatchSummaryModel *summaryModel, HBMatchCompareModel *compareModel))successBlock
                      errorBlock:(BJServiceErrorBlock)errorBlock mixcode:(NSString *)mixcode;

@end
