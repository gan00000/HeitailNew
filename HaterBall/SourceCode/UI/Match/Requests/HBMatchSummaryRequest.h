#import <Foundation/Foundation.h>
#import "HBBJHTTPServiceEngine.h"
#import "HBMatchSummaryModel.h"
#import "HBMatchCompareModel.h"
@interface HBMatchSummaryRequest : NSObject
+ (void)requestSummaryWithGameId:(NSString *)game_id
                    successBlock:(void(^)(HBMatchSummaryModel *summaryModel, HBMatchCompareModel *compareModel))successBlock
                      errorBlock:(BJServiceErrorBlock)errorBlock;
@end
