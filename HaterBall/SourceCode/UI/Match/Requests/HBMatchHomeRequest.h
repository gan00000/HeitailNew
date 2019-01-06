#import <Foundation/Foundation.h>
#import "HBBJHTTPServiceEngine.h"
#import "HBMatchHomeGroupModel.h"
@interface HBMatchHomeRequest : NSObject
+ (void)requestWithStartDate:(NSString *)startDate
                     endDate:(NSString *)endDate
                successBlock:(void(^)(NSArray<HBMatchHomeGroupModel *> *matchList))successBlock
                  errorBlock:(BJServiceErrorBlock)errorBlock;
+ (void)requestMatchProgressWithGameId:(NSString *)game_id
                          successBlock:(void(^)(NSString *game_id, NSString *quarter, NSString *time))successBlock
                            errorBlock:(BJServiceErrorBlock)errorBlock;
@end
