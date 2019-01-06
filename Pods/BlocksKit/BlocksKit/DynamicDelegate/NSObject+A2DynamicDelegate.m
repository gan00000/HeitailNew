#import <objc/runtime.h>
#import "NSObject+A2DynamicDelegate.h"
extern Protocol *a2_dataSourceProtocol(Class cls);
extern Protocol *a2_delegateProtocol(Class cls);
static Class a2_dynamicDelegateClass(Class cls, NSString *suffix)
{
	while (cls) {
		NSString *className = [NSString stringWithFormat:@"A2Dynamic%@%@", NSStringFromClass(cls), suffix];
		Class ddClass = NSClassFromString(className);
		if (ddClass) return ddClass;
		cls = class_getSuperclass(cls);
	}
	return [A2DynamicDelegate class];
}
static dispatch_queue_t a2_backgroundQueue(void)
{
	static dispatch_once_t onceToken;
	static dispatch_queue_t backgroundQueue = nil;
	dispatch_once(&onceToken, ^{
		backgroundQueue = dispatch_queue_create("BlocksKit.DynamicDelegate.Queue", DISPATCH_QUEUE_SERIAL);
	});
	return backgroundQueue;
}
@implementation NSObject (A2DynamicDelegate)
- (id)bk_dynamicDataSource
{
	Protocol *protocol = a2_dataSourceProtocol([self class]);
	Class class = a2_dynamicDelegateClass([self class], @"DataSource");
	return [self bk_dynamicDelegateWithClass:class forProtocol:protocol];
}
- (id)bk_dynamicDelegate
{
	Protocol *protocol = a2_delegateProtocol([self class]);
	Class class = a2_dynamicDelegateClass([self class], @"Delegate");
	return [self bk_dynamicDelegateWithClass:class forProtocol:protocol];
}
- (id)bk_dynamicDelegateForProtocol:(Protocol *)protocol
{
	Class class = [A2DynamicDelegate class];
	NSString *protocolName = NSStringFromProtocol(protocol);
	if ([protocolName hasSuffix:@"Delegate"]) {
		class = a2_dynamicDelegateClass([self class], @"Delegate");
	} else if ([protocolName hasSuffix:@"DataSource"]) {
		class = a2_dynamicDelegateClass([self class], @"DataSource");
	}
	return [self bk_dynamicDelegateWithClass:class forProtocol:protocol];
}
- (id)bk_dynamicDelegateWithClass:(Class)cls forProtocol:(Protocol *)protocol
{
	__block A2DynamicDelegate *dynamicDelegate;
	dispatch_sync(a2_backgroundQueue(), ^{
		dynamicDelegate = objc_getAssociatedObject(self, (__bridge const void *)protocol);
		if (!dynamicDelegate)
		{
			dynamicDelegate = [[cls alloc] initWithProtocol:protocol];
			objc_setAssociatedObject(self, (__bridge const void *)protocol, dynamicDelegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
		}
	});
	return dynamicDelegate;
}
@end
