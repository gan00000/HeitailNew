#import <Foundation/Foundation.h>
#import "NSNiceBJHTTPServiceEngine.h"
#import "CfipyHTNewsModel.h"
@interface NSNiceHTFilmHomeRequest : NSObject
@property (nonatomic, assign) BOOL hasMore;
- (void)taorequestWithSuccessBlock:(void(^)(NSArray<CfipyHTNewsModel *> *newsList))successBlock
                     errorBlock:(BJServiceErrorBlock)errorBlock;
- (void)loadNextPageWithSuccessBlock:(void(^)(NSArray<CfipyHTNewsModel *> *newsList))successBlock
                          errorBlock:(BJServiceErrorBlock)errorBlock;


- (void)requestRecommonedWithSuccessBlock:(void(^)(NSArray<CfipyHTNewsModel *> *newsList))successBlock
                     errorBlock:(BJServiceErrorBlock)errorBlock;

- (void)loadRecommonedNextPageWithVis:(NSString *)vids SuccessBlock:(void(^)(NSArray<CfipyHTNewsModel *> *newsList))successBlock
                          errorBlock:(BJServiceErrorBlock)errorBlock;

@end
