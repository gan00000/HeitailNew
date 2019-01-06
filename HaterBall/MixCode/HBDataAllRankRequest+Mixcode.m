#import "HBDataAllRankRequest+Mixcode.h"
@implementation HBDataAllRankRequest (Mixcode)
+ (void)requestAllTeamRankDataWithType:(NSString *)type
                          successBlock:(void(^)(NSArray<HBDataTeamRankModel *> *allTeamRankList))successBlock
                            errorBlock:(BJServiceErrorBlock)errorBlock mixcode:(NSString *)mixcode {
    NSLog(@"%@", mixcode);
}
+ (void)requestAllPlayerRankDataWithType:(NSString *)type
                            successBlock:(void(^)(NSArray<HBDataPlayerRankModel *> *allPlayerRankList))successBlock
                              errorBlock:(BJServiceErrorBlock)errorBlock mixcode:(NSString *)mixcode {
    NSLog(@"%@", mixcode);
}

@end
