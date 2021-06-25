#import <Foundation/Foundation.h>
#import "BlysaBJHTTPServiceEngine.h"
#import "UUaksHTNewsModel.h"
@interface YeYeeHTMainPageHomeRequest : NSObject
@property (nonatomic, assign) BOOL hasMore;
- (void)taorequestWithVids:(NSString *)vids successBlock:(void(^)(NSArray<UUaksHTNewsModel *> *newsList))successBlock
                     errorBlock:(BJServiceErrorBlock)errorBlock;
- (void)loadNextPageWithVids:(NSString *)vids successBlock:(void(^)(NSArray<UUaksHTNewsModel *> *newsList))successBlock
                          errorBlock:(BJServiceErrorBlock)errorBlock;
@end
