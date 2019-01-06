#import <Foundation/Foundation.h>
#import "HBBJHTTPServiceEngine.h"
#import "HBMatchHomeGroupModel.h"
#import "HBMatchHomeRequest.h"

@interface HBMatchHomeRequest (Mixcode)
+ (void)requestWithStartDate:(NSString *)startDate
                     endDate:(NSString *)endDate
                successBlock:(void(^)(NSArray<HBMatchHomeGroupModel *> *matchList))successBlock
                  errorBlock:(BJServiceErrorBlock)errorBlock mixcode:(NSString *)mixcode;
+ (void)requestMatchProgressWithGameId:(NSString *)game_id
                          successBlock:(void(^)(NSString *game_id, NSString *quarter, NSString *time))successBlock
                            errorBlock:(BJServiceErrorBlock)errorBlock mixcode:(NSString *)mixcode;

@end
