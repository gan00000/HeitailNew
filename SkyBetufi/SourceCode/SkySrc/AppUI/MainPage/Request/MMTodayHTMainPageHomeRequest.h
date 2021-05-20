#import <Foundation/Foundation.h>
#import "PXFunBJHTTPServiceEngine.h"
#import "PXFunHTNewsModel.h"
@interface MMTodayHTMainPageHomeRequest : NSObject
@property (nonatomic, assign) BOOL hasMore;
- (void)taorequestWithVids:(NSString *)vids successBlock:(void(^)(NSArray<PXFunHTNewsModel *> *newsList))successBlock
                     errorBlock:(BJServiceErrorBlock)errorBlock;
- (void)loadNextPageWithVids:(NSString *)vids successBlock:(void(^)(NSArray<PXFunHTNewsModel *> *newsList))successBlock
                          errorBlock:(BJServiceErrorBlock)errorBlock;
@end
