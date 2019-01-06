#import <Foundation/Foundation.h>
#import "HBBJHTTPServiceEngine.h"
#import "HBDataTeamRankModel.h"
#import "HBDataPlayerRankModel.h"
@interface HBDataAllRankRequest : NSObject
+ (void)requestAllTeamRankDataWithType:(NSString *)type
                          successBlock:(void(^)(NSArray<HBDataTeamRankModel *> *allTeamRankList))successBlock
                            errorBlock:(BJServiceErrorBlock)errorBlock;
+ (void)requestAllPlayerRankDataWithType:(NSString *)type
                            successBlock:(void(^)(NSArray<HBDataPlayerRankModel *> *allPlayerRankList))successBlock
                              errorBlock:(BJServiceErrorBlock)errorBlock;
@end
