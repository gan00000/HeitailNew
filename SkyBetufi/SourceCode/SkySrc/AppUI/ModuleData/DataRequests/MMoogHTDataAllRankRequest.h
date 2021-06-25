#import <Foundation/Foundation.h>
#import "BlysaBJHTTPServiceEngine.h"
#import "TuTuosHTDataTeamRankModel.h"
#import "TuTuosHTDataPlayerRankModel.h"
@interface MMoogHTDataAllRankRequest : NSObject
+ (void)taorequestAllTeamRankDataWithType:(NSString *)type
                          successBlock:(void(^)(NSArray<TuTuosHTDataTeamRankModel *> *allTeamRankList))successBlock
                            errorBlock:(BJServiceErrorBlock)errorBlock;
+ (void)requestAllPlayerRankDataWithType:(NSString *)type
                            successBlock:(void(^)(NSArray<TuTuosHTDataPlayerRankModel *> *allPlayerRankList))successBlock
                              errorBlock:(BJServiceErrorBlock)errorBlock;
@end
