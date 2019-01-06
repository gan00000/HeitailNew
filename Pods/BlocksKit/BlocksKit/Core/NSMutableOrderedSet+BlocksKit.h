#import <Foundation/Foundation.h>
@interface NSMutableOrderedSet (BlocksKit)
- (void)bk_performSelect:(BOOL (^)(id obj))block;
- (void)bk_performReject:(BOOL (^)(id obj))block;
- (void)bk_performMap:(id (^)(id obj))block;
@end
