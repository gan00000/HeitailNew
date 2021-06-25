#import <Foundation/Foundation.h>
#import "NSNiceBJHTTPServiceEngine.h"
#import "TuTuosHTDataHomeInfoModel.h"
@interface BByasHTDataHomeRequest : NSObject
+ (void)taorequestWithType:(NSInteger)type successBlock:(void(^)(TuTuosHTDataHomeInfoModel *infoModel))successBlock errorBlock:(BJServiceErrorBlock)errorBlock;
@end
