#import <Foundation/Foundation.h>
#import "PXFunBJHTTPServiceEngine.h"
#import "CCCaseHTDataHomeInfoModel.h"
@interface RRDogHTDataHomeRequest : NSObject
+ (void)taorequestWithType:(NSInteger)type successBlock:(void(^)(CCCaseHTDataHomeInfoModel *infoModel))successBlock errorBlock:(BJServiceErrorBlock)errorBlock;
@end
