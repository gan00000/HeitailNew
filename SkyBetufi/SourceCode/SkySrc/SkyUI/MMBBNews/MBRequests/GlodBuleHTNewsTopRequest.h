#import <Foundation/Foundation.h>
#import "GlodBuleBJHTTPServiceEngine.h"
#import "GlodBuleHTNewsModel.h"
@interface GlodBuleHTNewsTopRequest : NSObject
+ (void)waterSkyrequestWithSuccessBlock:(void(^)(NSArray<GlodBuleHTNewsModel *> *newsList))successBlock
                     errorBlock:(BJServiceErrorBlock)errorBlock;
@end
