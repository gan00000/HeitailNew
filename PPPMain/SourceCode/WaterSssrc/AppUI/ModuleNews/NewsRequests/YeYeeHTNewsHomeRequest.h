#import <Foundation/Foundation.h>
#import "NSNiceBJHTTPServiceEngine.h"
#import "CfipyHTNewsModel.h"
@interface YeYeeHTNewsHomeRequest : NSObject
@property (nonatomic, assign) BOOL hasMore;
- (void)taorequestWithSuccessBlock:(void(^)(NSArray<CfipyHTNewsModel *> *newsList))successBlock
                     errorBlock:(BJServiceErrorBlock)errorBlock;
- (void)taoloadNextPageWithSuccessBlock:(void(^)(NSArray<CfipyHTNewsModel *> *newsList))successBlock
                          errorBlock:(BJServiceErrorBlock)errorBlock;

+(void)taorequestHighLightWithGameId:(NSString *)gameId successBlock:(void(^)(NSArray<CfipyHTNewsModel *> *newsList))successBlock
                          errorBlock:(BJServiceErrorBlock)errorBlock;
@end
