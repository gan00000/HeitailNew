#import <Foundation/Foundation.h>
#import "HBBJHTTPServiceEngine.h"
#import "HBDataHomeInfoModel.h"
#import "HBDataHomeRequest.h"

@interface HBDataHomeRequest (Mixcode)
+ (void)requestWithType:(NSInteger)type successBlock:(void(^)(HBDataHomeInfoModel *infoModel))successBlock errorBlock:(BJServiceErrorBlock)errorBlock mixcode:(NSString *)mixcode;

@end
