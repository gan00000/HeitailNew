#import <Foundation/Foundation.h>
@interface NSCache (BlocksKit)
- (id)bk_objectForKey:(id)key withGetter:(id (^)(void))getterBlock;
@property (nonatomic, copy, setter = bk_setWillEvictBlock:) void (^bk_willEvictBlock)(NSCache *cache, id obj);
@end
