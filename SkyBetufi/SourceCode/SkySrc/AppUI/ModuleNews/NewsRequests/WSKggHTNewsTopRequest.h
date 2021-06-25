#import <Foundation/Foundation.h>
#import "BlysaBJHTTPServiceEngine.h"
#import "UUaksHTNewsModel.h"
@interface WSKggHTNewsTopRequest : NSObject
+ (void)taorequestWithSuccessBlock:(void(^)(NSArray<UUaksHTNewsModel *> *newsList))successBlock
                     errorBlock:(BJServiceErrorBlock)errorBlock;
@end
