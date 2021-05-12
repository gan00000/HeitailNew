#import <Foundation/Foundation.h>
#import "PXFunBJHTTPServiceEngine.h"
#import "HourseHTDataTeamRankModel.h"
#import "NDeskHTDataPlayerRankModel.h"
@interface GGCatHTDataAllRankRequest : NSObject
+ (void)taorequestAllTeamRankDataWithType:(NSString *)type
                          successBlock:(void(^)(NSArray<HourseHTDataTeamRankModel *> *allTeamRankList))successBlock
                            errorBlock:(BJServiceErrorBlock)errorBlock;
+ (void)requestAllPlayerRankDataWithType:(NSString *)type
                            successBlock:(void(^)(NSArray<NDeskHTDataPlayerRankModel *> *allPlayerRankList))successBlock
                              errorBlock:(BJServiceErrorBlock)errorBlock;
@end
