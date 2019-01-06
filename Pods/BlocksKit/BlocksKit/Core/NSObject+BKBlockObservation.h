#import <Foundation/Foundation.h>
@interface NSObject (BlockObservation)
- (NSString *)bk_addObserverForKeyPath:(NSString *)keyPath task:(void (^)(id target))task;
- (NSString *)bk_addObserverForKeyPaths:(NSArray *)keyPaths task:(void (^)(id obj, NSString *keyPath))task;
- (NSString *)bk_addObserverForKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options task:(void (^)(id obj, NSDictionary *change))task;
- (NSString *)bk_addObserverForKeyPaths:(NSArray *)keyPaths options:(NSKeyValueObservingOptions)options task:(void (^)(id obj, NSString *keyPath, NSDictionary *change))task;
- (void)bk_addObserverForKeyPath:(NSString *)keyPath identifier:(NSString *)token options:(NSKeyValueObservingOptions)options task:(void (^)(id obj, NSDictionary *change))task;
- (void)bk_addObserverForKeyPaths:(NSArray *)keyPaths identifier:(NSString *)token options:(NSKeyValueObservingOptions)options task:(void (^)(id obj, NSString *keyPath, NSDictionary *change))task;
- (void)bk_removeObserverForKeyPath:(NSString *)keyPath identifier:(NSString *)token;
- (void)bk_removeObserversWithIdentifier:(NSString *)token;
- (void)bk_removeAllBlockObservers;
@end
