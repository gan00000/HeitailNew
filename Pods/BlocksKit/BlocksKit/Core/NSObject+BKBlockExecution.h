#import <Foundation/Foundation.h>
@interface NSObject (BKBlockExecution)
- (id)bk_performBlock:(void (^)(id obj))block afterDelay:(NSTimeInterval)delay;
+ (id)bk_performBlock:(void (^)(void))block afterDelay:(NSTimeInterval)delay;
- (id)bk_performBlockInBackground:(void (^)(id obj))block afterDelay:(NSTimeInterval)delay;
+ (id)bk_performBlockInBackground:(void (^)(void))block afterDelay:(NSTimeInterval)delay;
+ (id)bk_performBlock:(void (^)(void))block onQueue:(dispatch_queue_t)queue afterDelay:(NSTimeInterval)delay;
- (id)bk_performBlock:(void (^)(id obj))block onQueue:(dispatch_queue_t)queue afterDelay:(NSTimeInterval)delay;
+ (void)bk_cancelBlock:(id)block;
@end
