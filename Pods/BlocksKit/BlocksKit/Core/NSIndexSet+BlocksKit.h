#import <Foundation/Foundation.h>
@interface NSIndexSet (BlocksKit)
- (void)bk_each:(void (^)(NSUInteger index))block;
- (void)bk_apply:(void (^)(NSUInteger index))block;
- (NSUInteger)bk_match:(BOOL (^)(NSUInteger index))block;
- (NSIndexSet *)bk_select:(BOOL (^)(NSUInteger index))block;
- (NSIndexSet *)bk_reject:(BOOL (^)(NSUInteger index))block;
- (NSIndexSet *)bk_map:(NSUInteger (^)(NSUInteger index))block;
- (NSArray *)bk_mapIndex:(id (^)(NSUInteger index))block;
- (BOOL)bk_any:(BOOL (^)(NSUInteger index))block;
- (BOOL)bk_all:(BOOL (^)(NSUInteger index))block;
- (BOOL)bk_none:(BOOL (^)(NSUInteger index))block;
@end
