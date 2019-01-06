#import <Foundation/Foundation.h>
@interface NSMutableDictionary (BlocksKit)
- (void)bk_performSelect:(BOOL (^)(id key, id obj))block;
- (void)bk_performReject:(BOOL (^)(id key, id obj))block;
- (void)bk_performMap:(id (^)(id key, id obj))block;
@end
