#import <Foundation/Foundation.h>
#import "XRRFATKBJHTTPServiceEngine.h"
#import "XRRFATKHTNewsModel.h"
@interface XRRFATKHTNewsHomeRequest : NSObject
@property (nonatomic, assign) BOOL hasMore;
- (void)skargrequestWithSuccessBlock:(void(^)(NSArray<XRRFATKHTNewsModel *> *newsList))successBlock
                     errorBlock:(BJServiceErrorBlock)errorBlock;
- (void)skargloadNextPageWithSuccessBlock:(void(^)(NSArray<XRRFATKHTNewsModel *> *newsList))successBlock
                          errorBlock:(BJServiceErrorBlock)errorBlock;
@end
