#import <Foundation/Foundation.h>
#import "HBBJHTTPServiceEngine.h"
#import "HBNewsModel.h"
#import "HBNewsHomeRequest.h"

@interface HBNewsHomeRequest (Mixcode)
- (void)requestWithSuccessBlock:(void(^)(NSArray<HBNewsModel *> *newsList))successBlock
                     errorBlock:(BJServiceErrorBlock)errorBlock mixcode:(NSString *)mixcode;
- (void)loadNextPageWithSuccessBlock:(void(^)(NSArray<HBNewsModel *> *newsList))successBlock
                          errorBlock:(BJServiceErrorBlock)errorBlock mixcode:(NSString *)mixcode;

@end
