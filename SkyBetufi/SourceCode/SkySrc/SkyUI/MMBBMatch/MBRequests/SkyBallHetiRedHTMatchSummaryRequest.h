#import <Foundation/Foundation.h>
#import "SkyBallHetiRedBJHTTPServiceEngine.h"
#import "SkyBallHetiRedHTMatchSummaryModel.h"
#import "SkyBallHetiRedHTMatchCompareModel.h"
@interface SkyBallHetiRedHTMatchSummaryRequest : NSObject
+ (void)waterSkyrequestSummaryWithGameId:(NSString *)game_id
                    successBlock:(void(^)(SkyBallHetiRedHTMatchSummaryModel *summaryModel, SkyBallHetiRedHTMatchCompareModel *compareModel))successBlock
                      errorBlock:(BJServiceErrorBlock)errorBlock;
@end
