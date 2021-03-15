#import <Foundation/Foundation.h>
#import "GlodBuleBJHTTPServiceEngine.h"
#import "GlodBuleHTMatchHomeGroupModel.h"
@interface GlodBuleHTMatchHomeRequest : NSObject
+ (void)taorequestWithStartDate:(NSString *)startDate
                     endDate:(NSString *)endDate
                 competition_id:(NSString *)competition_id
                successBlock:(void(^)(NSArray<GlodBuleHTMatchHomeGroupModel *> *matchList, NSArray<GlodBuleHTMatchHomeModel *> *matchA))successBlock
                  errorBlock:(BJServiceErrorBlock)errorBlock;
+ (void)taorequestMatchProgressWithGameId:(NSString *)game_id
                          successBlock:(void(^)(NSString *game_id, NSString *quarter, NSString *time))successBlock
                            errorBlock:(BJServiceErrorBlock)errorBlock;

+ (void)get_league_list_successBlock:(void(^)(NSDictionary *leagueList))successBlock
                          errorBlock:(BJServiceErrorBlock)errorBlock;
@end
