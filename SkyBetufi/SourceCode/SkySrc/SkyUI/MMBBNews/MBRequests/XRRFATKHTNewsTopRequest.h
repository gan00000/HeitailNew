#import <Foundation/Foundation.h>
#import "XRRFATKBJHTTPServiceEngine.h"
#import "XRRFATKHTNewsModel.h"
@interface XRRFATKHTNewsTopRequest : NSObject
+ (void)skargrequestWithSuccessBlock:(void(^)(NSArray<XRRFATKHTNewsModel *> *newsList))successBlock
                     errorBlock:(BJServiceErrorBlock)errorBlock;
@end
