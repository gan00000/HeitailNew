#import <Foundation/Foundation.h>
#import "HBBJHTTPServiceEngine.h"
#import "HBNewsModel.h"
@interface HBNewsTopRequest : NSObject
+ (void)requestWithSuccessBlock:(void(^)(NSArray<HBNewsModel *> *newsList))successBlock
                     errorBlock:(BJServiceErrorBlock)errorBlock;
@end
