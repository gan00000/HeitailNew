#import <Foundation/Foundation.h>
#import "SkyBallHetiRedBJHTTPServiceEngine.h"
#import "SkyBallHetiRedHTNewsModel.h"
@interface SkyBallHetiRedHTNewsHomeRequest : NSObject
@property (nonatomic, assign) BOOL hasMore;
- (void)waterSkyrequestWithSuccessBlock:(void(^)(NSArray<SkyBallHetiRedHTNewsModel *> *newsList))successBlock
                     errorBlock:(BJServiceErrorBlock)errorBlock;
- (void)waterSkyloadNextPageWithSuccessBlock:(void(^)(NSArray<SkyBallHetiRedHTNewsModel *> *newsList))successBlock
                          errorBlock:(BJServiceErrorBlock)errorBlock;
@end
