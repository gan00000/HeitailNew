#import <Foundation/Foundation.h>
#import "NSNiceBJHTTPServiceEngine.h"
#import "CfipyHTNewsModel.h"
@interface BlysaHTNewsTopRequest : NSObject
+ (void)taorequestWithSuccessBlock:(void(^)(NSArray<CfipyHTNewsModel *> *newsList))successBlock
                     errorBlock:(BJServiceErrorBlock)errorBlock;
@end
