#import <Foundation/Foundation.h>
#import "BlysaBJHTTPServiceEngine.h"
#import "KSasxHTDataHomeInfoModel.h"
@interface BByasHTDataHomeRequest : NSObject
+ (void)taorequestWithType:(NSInteger)type successBlock:(void(^)(KSasxHTDataHomeInfoModel *infoModel))successBlock errorBlock:(BJServiceErrorBlock)errorBlock;
@end
