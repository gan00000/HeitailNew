#import <Foundation/Foundation.h>
#import "HBBJHTTPServiceEngine.h"
#import "HBDataTeamRankModel.h"
#import "HBDataPlayerRankModel.h"
#import "HBDataAllRankRequest.h"

@interface HBDataAllRankRequest (Mixcode)
+ (void)requestAllTeamRankDataWithType:(NSString *)type
                          successBlock:(void(^)(NSArray<HBDataTeamRankModel *> *allTeamRankList))successBlock
                            errorBlock:(BJServiceErrorBlock)errorBlock mixcode:(NSString *)mixcode;
+ (void)requestAllPlayerRankDataWithType:(NSString *)type
                            successBlock:(void(^)(NSArray<HBDataPlayerRankModel *> *allPlayerRankList))successBlock
                              errorBlock:(BJServiceErrorBlock)errorBlock mixcode:(NSString *)mixcode;

@end
