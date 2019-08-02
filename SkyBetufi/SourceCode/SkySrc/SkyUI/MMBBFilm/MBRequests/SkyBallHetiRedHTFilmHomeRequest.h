#import <Foundation/Foundation.h>
#import "SkyBallHetiRedBJHTTPServiceEngine.h"
#import "SkyBallHetiRedHTNewsModel.h"
@interface SkyBallHetiRedHTFilmHomeRequest : NSObject
@property (nonatomic, assign) BOOL hasMore;
- (void)waterSkyrequestWithSuccessBlock:(void(^)(NSArray<SkyBallHetiRedHTNewsModel *> *newsList))successBlock
                     errorBlock:(BJServiceErrorBlock)errorBlock;
- (void)loadNextPageWithSuccessBlock:(void(^)(NSArray<SkyBallHetiRedHTNewsModel *> *newsList))successBlock
                          errorBlock:(BJServiceErrorBlock)errorBlock;
@end
