#import <Foundation/Foundation.h>
#import "NSNiceBJHTTPServiceEngine.h"
#import "CfipyHTNewsModel.h"
@interface UUaksHTMainPageHomeRequest : NSObject
@property (nonatomic, assign) BOOL hasMore;
- (void)taorequestWithVids:(NSString *)vids successBlock:(void(^)(NSArray<CfipyHTNewsModel *> *newsList))successBlock
                     errorBlock:(BJServiceErrorBlock)errorBlock;
- (void)loadNextPageWithVids:(NSString *)vids successBlock:(void(^)(NSArray<CfipyHTNewsModel *> *newsList))successBlock
                          errorBlock:(BJServiceErrorBlock)errorBlock;
@end
