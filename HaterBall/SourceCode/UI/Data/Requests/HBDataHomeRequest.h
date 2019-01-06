#import <Foundation/Foundation.h>
#import "HBBJHTTPServiceEngine.h"
#import "HBDataHomeInfoModel.h"
@interface HBDataHomeRequest : NSObject
+ (void)requestWithType:(NSInteger)type successBlock:(void(^)(HBDataHomeInfoModel *infoModel))successBlock errorBlock:(BJServiceErrorBlock)errorBlock;
@end
