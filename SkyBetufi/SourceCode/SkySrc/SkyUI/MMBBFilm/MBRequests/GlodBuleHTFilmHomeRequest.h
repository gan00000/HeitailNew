#import <Foundation/Foundation.h>
#import "GlodBuleBJHTTPServiceEngine.h"
#import "GlodBuleHTNewsModel.h"
@interface GlodBuleHTFilmHomeRequest : NSObject
@property (nonatomic, assign) BOOL hasMore;
- (void)waterSkyrequestWithSuccessBlock:(void(^)(NSArray<GlodBuleHTNewsModel *> *newsList))successBlock
                     errorBlock:(BJServiceErrorBlock)errorBlock;
- (void)loadNextPageWithSuccessBlock:(void(^)(NSArray<GlodBuleHTNewsModel *> *newsList))successBlock
                          errorBlock:(BJServiceErrorBlock)errorBlock;
@end
