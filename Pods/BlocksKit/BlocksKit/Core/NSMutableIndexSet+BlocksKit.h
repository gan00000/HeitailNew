#import <Foundation/Foundation.h>
@interface NSMutableIndexSet (BlocksKit)
- (void)bk_performSelect:(BOOL (^)(NSUInteger index))block;
- (void)bk_performReject:(BOOL (^)(NSUInteger index))block;
- (void)bk_performMap:(NSUInteger (^)(NSUInteger index))block;
@end
