#import <Foundation/Foundation.h>
#import "GlodBuleBJHTTPServiceEngine.h"
#import "GlodBuleHTNewsModel.h"
@interface GlodBuleHTNewsHomeRequest : NSObject
@property (nonatomic, assign) BOOL hasMore;
- (void)waterSkyrequestWithSuccessBlock:(void(^)(NSArray<GlodBuleHTNewsModel *> *newsList))successBlock
                     errorBlock:(BJServiceErrorBlock)errorBlock;
- (void)waterSkyloadNextPageWithSuccessBlock:(void(^)(NSArray<GlodBuleHTNewsModel *> *newsList))successBlock
                          errorBlock:(BJServiceErrorBlock)errorBlock;
@end
