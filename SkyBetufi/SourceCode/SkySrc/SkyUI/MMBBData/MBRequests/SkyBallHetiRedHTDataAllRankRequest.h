#import <Foundation/Foundation.h>
#import "SkyBallHetiRedBJHTTPServiceEngine.h"
#import "SkyBallHetiRedHTDataTeamRankModel.h"
#import "SkyBallHetiRedHTDataPlayerRankModel.h"
@interface SkyBallHetiRedHTDataAllRankRequest : NSObject
+ (void)waterSkyrequestAllTeamRankDataWithType:(NSString *)type
                          successBlock:(void(^)(NSArray<SkyBallHetiRedHTDataTeamRankModel *> *allTeamRankList))successBlock
                            errorBlock:(BJServiceErrorBlock)errorBlock;
+ (void)requestAllPlayerRankDataWithType:(NSString *)type
                            successBlock:(void(^)(NSArray<SkyBallHetiRedHTDataPlayerRankModel *> *allPlayerRankList))successBlock
                              errorBlock:(BJServiceErrorBlock)errorBlock;
@end
