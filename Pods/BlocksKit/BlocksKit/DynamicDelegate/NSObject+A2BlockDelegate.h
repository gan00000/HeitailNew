#import <Foundation/Foundation.h>
@interface NSObject (A2BlockDelegate)
+ (void)bk_linkDataSourceMethods:(NSDictionary *)selectorsForPropertyNames;
+ (void)bk_linkDelegateMethods:(NSDictionary *)selectorsForPropertyNames;
+ (void)bk_linkProtocol:(Protocol *)protocol methods:(NSDictionary *)selectorsForPropertyNames;
+ (void)bk_registerDynamicDataSource;
+ (void)bk_registerDynamicDelegate;
+ (void)bk_registerDynamicDataSourceNamed:(NSString *)dataSourceName;
+ (void)bk_registerDynamicDelegateNamed:(NSString *)delegateName;
+ (void)bk_registerDynamicDelegateNamed:(NSString *)delegateName forProtocol:(Protocol *)protocol;
- (id)bk_ensuredDynamicDelegate;
- (id)bk_ensuredDynamicDelegateForProtocol:(Protocol *)protocol;
@end
