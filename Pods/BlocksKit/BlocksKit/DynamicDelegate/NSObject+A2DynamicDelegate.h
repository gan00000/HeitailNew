#import <BlocksKit/A2DynamicDelegate.h>
#import <Foundation/Foundation.h>
@interface NSObject (A2DynamicDelegate)
- (id)bk_dynamicDataSource;
- (id)bk_dynamicDelegate;
- (id)bk_dynamicDelegateForProtocol:(Protocol *)protocol;
@end
