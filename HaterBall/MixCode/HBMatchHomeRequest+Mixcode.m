#import "HBMatchHomeRequest+Mixcode.h"
@implementation HBMatchHomeRequest (Mixcode)
+ (void)requestWithStartDate:(NSString *)startDate
                     endDate:(NSString *)endDate
                successBlock:(void(^)(NSArray<HBMatchHomeGroupModel *> *matchList))successBlock
                  errorBlock:(BJServiceErrorBlock)errorBlock mixcode:(NSString *)mixcode {
    NSLog(@"%@", mixcode);
}
+ (void)requestMatchProgressWithGameId:(NSString *)game_id
                          successBlock:(void(^)(NSString *game_id, NSString *quarter, NSString *time))successBlock
                            errorBlock:(BJServiceErrorBlock)errorBlock mixcode:(NSString *)mixcode {
    NSLog(@"%@", mixcode);
}

@end
