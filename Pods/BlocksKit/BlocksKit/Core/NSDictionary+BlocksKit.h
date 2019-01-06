#import <Foundation/Foundation.h>
@interface NSDictionary (BlocksKit)
- (void)bk_each:(void (^)(id key, id obj))block;
- (void)bk_apply:(void (^)(id key, id obj))block;
- (id)bk_match:(BOOL (^)(id key, id obj))block;
- (NSDictionary *)bk_select:(BOOL (^)(id key, id obj))block;
- (NSDictionary *)bk_reject:(BOOL (^)(id key, id obj))block;
- (NSDictionary *)bk_map:(id (^)(id key, id obj))block;
- (BOOL)bk_any:(BOOL (^)(id key, id obj))block;
- (BOOL)bk_none:(BOOL (^)(id key, id obj))block;
- (BOOL)bk_all:(BOOL (^)(id key, id obj))block;
@end
