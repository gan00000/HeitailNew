#import <Foundation/Foundation.h>
#import "BlysaBJHTTPServiceEngine.h"
#import "UUaksHTNewsModel.h"
@interface BByasHTNewsHomeRequest : NSObject
@property (nonatomic, assign) BOOL hasMore;
- (void)taorequestWithSuccessBlock:(void(^)(NSArray<UUaksHTNewsModel *> *newsList))successBlock
                     errorBlock:(BJServiceErrorBlock)errorBlock;
- (void)taoloadNextPageWithSuccessBlock:(void(^)(NSArray<UUaksHTNewsModel *> *newsList))successBlock
                          errorBlock:(BJServiceErrorBlock)errorBlock;

+(void)taorequestHighLightWithGameId:(NSString *)gameId successBlock:(void(^)(NSArray<UUaksHTNewsModel *> *newsList))successBlock
                          errorBlock:(BJServiceErrorBlock)errorBlock;
@end
