#import <Foundation/Foundation.h>
#import "HBBJHTTPServiceEngine.h"
#import "HBNewsModel.h"
#import "HBFilmHomeRequest.h"

@interface HBFilmHomeRequest (Mixcode)
- (void)requestWithSuccessBlock:(void(^)(NSArray<HBNewsModel *> *newsList))successBlock
                     errorBlock:(BJServiceErrorBlock)errorBlock mixcode:(NSString *)mixcode;
- (void)loadNextPageWithSuccessBlock:(void(^)(NSArray<HBNewsModel *> *newsList))successBlock
                          errorBlock:(BJServiceErrorBlock)errorBlock mixcode:(NSString *)mixcode;

@end
