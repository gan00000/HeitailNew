#import <Foundation/Foundation.h>
#import "HBBJHTTPServiceEngine.h"
#import "HBNewsModel.h"
@interface HBFilmHomeRequest : NSObject
@property (nonatomic, assign) BOOL hasMore;
- (void)requestWithSuccessBlock:(void(^)(NSArray<HBNewsModel *> *newsList))successBlock
                     errorBlock:(BJServiceErrorBlock)errorBlock;
- (void)loadNextPageWithSuccessBlock:(void(^)(NSArray<HBNewsModel *> *newsList))successBlock
                          errorBlock:(BJServiceErrorBlock)errorBlock;
@end
