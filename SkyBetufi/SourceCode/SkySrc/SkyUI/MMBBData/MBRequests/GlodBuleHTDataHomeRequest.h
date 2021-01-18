#import <Foundation/Foundation.h>
#import "GlodBuleBJHTTPServiceEngine.h"
#import "GlodBuleHTDataHomeInfoModel.h"
@interface GlodBuleHTDataHomeRequest : NSObject
+ (void)waterSkyrequestWithType:(NSInteger)type successBlock:(void(^)(GlodBuleHTDataHomeInfoModel *infoModel))successBlock errorBlock:(BJServiceErrorBlock)errorBlock;
@end
