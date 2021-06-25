#import <Foundation/Foundation.h>
#import "BlysaBJHTTPServiceEngine.h"
#import "UUaksHTNewsModel.h"
@interface TuTuosHTFilmHomeRequest : NSObject
@property (nonatomic, assign) BOOL hasMore;
- (void)taorequestWithSuccessBlock:(void(^)(NSArray<UUaksHTNewsModel *> *newsList))successBlock
                     errorBlock:(BJServiceErrorBlock)errorBlock;
- (void)loadNextPageWithSuccessBlock:(void(^)(NSArray<UUaksHTNewsModel *> *newsList))successBlock
                          errorBlock:(BJServiceErrorBlock)errorBlock;
@end
