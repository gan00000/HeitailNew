#import <Foundation/Foundation.h>
#import <CoreGraphics/CGBase.h>
@interface NSArray (BlocksKit)
- (void)bk_each:(void (^)(id obj))block;
- (void)bk_apply:(void (^)(id obj))block;
- (id)bk_match:(BOOL (^)(id obj))block;
- (NSArray *)bk_select:(BOOL (^)(id obj))block;
- (NSArray *)bk_reject:(BOOL (^)(id obj))block;
- (NSArray *)bk_map:(id (^)(id obj))block;
- (id)bk_reduce:(id)initial withBlock:(id (^)(id sum, id obj))block;
- (NSInteger)bk_reduceInteger:(NSInteger)initial withBlock:(NSInteger(^)(NSInteger result, id obj))block;
- (CGFloat)bk_reduceFloat:(CGFloat)inital withBlock:(CGFloat(^)(CGFloat result, id obj))block;
- (BOOL)bk_any:(BOOL (^)(id obj))block;
- (BOOL)bk_none:(BOOL (^)(id obj))block;
- (BOOL)bk_all:(BOOL (^)(id obj))block;
- (BOOL)bk_corresponds:(NSArray *)list withBlock:(BOOL (^)(id obj1, id obj2))block;
@end
