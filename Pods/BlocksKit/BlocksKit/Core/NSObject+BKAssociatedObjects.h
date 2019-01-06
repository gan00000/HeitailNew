#import <Foundation/Foundation.h>
@interface NSObject (BKAssociatedObjects)
- (void)bk_associateValue:(id)value withKey:(const void *)key;
+ (void)bk_associateValue:(id)value withKey:(const void *)key;
- (void)bk_atomicallyAssociateValue:(id)value withKey:(const void *)key;
+ (void)bk_atomicallyAssociateValue:(id)value withKey:(const void *)key;
- (void)bk_associateCopyOfValue:(id)value withKey:(const void *)key;
+ (void)bk_associateCopyOfValue:(id)value withKey:(const void *)key;
- (void)bk_atomicallyAssociateCopyOfValue:(id)value withKey:(const void *)key;
+ (void)bk_atomicallyAssociateCopyOfValue:(id)value withKey:(const void *)key;
- (void)bk_weaklyAssociateValue:(__autoreleasing id)value withKey:(const void *)key;
+ (void)bk_weaklyAssociateValue:(__autoreleasing id)value withKey:(const void *)key;
- (id)bk_associatedValueForKey:(const void *)key;
+ (id)bk_associatedValueForKey:(const void *)key;
- (void)bk_removeAllAssociatedObjects;
+ (void)bk_removeAllAssociatedObjects;
@end
