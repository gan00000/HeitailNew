#import <Foundation/Foundation.h>
#import "PXFunBJHTTPServiceEngine.h"
#import "PXFunHTNewsModel.h"
@interface KMonkeyHTNewsTopRequest : NSObject
+ (void)taorequestWithSuccessBlock:(void(^)(NSArray<PXFunHTNewsModel *> *newsList))successBlock
                     errorBlock:(BJServiceErrorBlock)errorBlock;
@end
