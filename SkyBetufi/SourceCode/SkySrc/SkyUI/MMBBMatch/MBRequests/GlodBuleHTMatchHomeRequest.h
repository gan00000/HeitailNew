#import <Foundation/Foundation.h>
#import "GlodBuleBJHTTPServiceEngine.h"
#import "GlodBuleHTMatchHomeGroupModel.h"
@interface GlodBuleHTMatchHomeRequest : NSObject
+ (void)waterSkyrequestWithStartDate:(NSString *)startDate
                     endDate:(NSString *)endDate
                successBlock:(void(^)(NSArray<GlodBuleHTMatchHomeGroupModel *> *matchList, NSArray<GlodBuleHTMatchHomeModel *> *matchA))successBlock
                  errorBlock:(BJServiceErrorBlock)errorBlock;
+ (void)waterSkyrequestMatchProgressWithGameId:(NSString *)game_id
                          successBlock:(void(^)(NSString *game_id, NSString *quarter, NSString *time))successBlock
                            errorBlock:(BJServiceErrorBlock)errorBlock;
@end
