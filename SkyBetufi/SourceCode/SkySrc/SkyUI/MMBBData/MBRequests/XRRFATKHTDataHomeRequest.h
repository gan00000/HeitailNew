#import <Foundation/Foundation.h>
#import "XRRFATKBJHTTPServiceEngine.h"
#import "XRRFATKHTDataHomeInfoModel.h"
@interface XRRFATKHTDataHomeRequest : NSObject
+ (void)skargrequestWithType:(NSInteger)type successBlock:(void(^)(XRRFATKHTDataHomeInfoModel *infoModel))successBlock errorBlock:(BJServiceErrorBlock)errorBlock;
@end
