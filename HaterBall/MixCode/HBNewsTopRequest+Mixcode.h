#import <Foundation/Foundation.h>
#import "HBBJHTTPServiceEngine.h"
#import "HBNewsModel.h"
#import "HBNewsTopRequest.h"

@interface HBNewsTopRequest (Mixcode)
+ (void)requestWithSuccessBlock:(void(^)(NSArray<HBNewsModel *> *newsList))successBlock
                     errorBlock:(BJServiceErrorBlock)errorBlock mixcode:(NSString *)mixcode;

@end
