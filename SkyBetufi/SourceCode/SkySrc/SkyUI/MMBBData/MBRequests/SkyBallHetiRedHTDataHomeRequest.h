#import <Foundation/Foundation.h>
#import "SkyBallHetiRedBJHTTPServiceEngine.h"
#import "SkyBallHetiRedHTDataHomeInfoModel.h"
@interface SkyBallHetiRedHTDataHomeRequest : NSObject
+ (void)waterSkyrequestWithType:(NSInteger)type successBlock:(void(^)(SkyBallHetiRedHTDataHomeInfoModel *infoModel))successBlock errorBlock:(BJServiceErrorBlock)errorBlock;
@end
