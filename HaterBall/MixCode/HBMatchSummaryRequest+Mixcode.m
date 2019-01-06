#import "HBMatchSummaryRequest+Mixcode.h"
@implementation HBMatchSummaryRequest (Mixcode)
+ (void)requestSummaryWithGameId:(NSString *)game_id
                    successBlock:(void(^)(HBMatchSummaryModel *summaryModel, HBMatchCompareModel *compareModel))successBlock
                      errorBlock:(BJServiceErrorBlock)errorBlock mixcode:(NSString *)mixcode {
    NSLog(@"%@", mixcode);
}

@end
