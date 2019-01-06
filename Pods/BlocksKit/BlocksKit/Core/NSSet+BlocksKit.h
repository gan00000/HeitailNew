#import <Foundation/Foundation.h>
@interface NSSet (BlocksKit)
- (void)bk_each:(void (^)(id obj))block;
- (void)bk_apply:(void (^)(id obj))block;
- (id)bk_match:(BOOL (^)(id obj))block;
- (NSSet *)bk_select:(BOOL (^)(id obj))block;
- (NSSet *)bk_reject:(BOOL (^)(id obj))block;
- (NSSet *)bk_map:(id (^)(id obj))block;
- (id)bk_reduce:(id)initial withBlock:(id (^)(id sum, id obj))block;
- (BOOL)bk_any:(BOOL (^)(id obj))block;
- (BOOL)bk_none:(BOOL (^)(id obj))block;
- (BOOL)bk_all:(BOOL (^)(id obj))block;
@end
