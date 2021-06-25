#import <Foundation/Foundation.h>
#import "NSNiceBJHTTPServiceEngine.h"
#import "YeYeeHTDataTeamRankModel.h"
#import "KSasxHTDataPlayerRankModel.h"
@interface UUaksHTDataAllRankRequest : NSObject
+ (void)taorequestAllTeamRankDataWithType:(NSString *)type
                          successBlock:(void(^)(NSArray<YeYeeHTDataTeamRankModel *> *allTeamRankList))successBlock
                            errorBlock:(BJServiceErrorBlock)errorBlock;
+ (void)requestAllPlayerRankDataWithType:(NSString *)type
                            successBlock:(void(^)(NSArray<KSasxHTDataPlayerRankModel *> *allPlayerRankList))successBlock
                              errorBlock:(BJServiceErrorBlock)errorBlock;
@end
