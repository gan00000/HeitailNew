#import <Foundation/Foundation.h>
#import <BlocksKit/NSObject+A2BlockDelegate.h>
#import <BlocksKit/NSObject+A2DynamicDelegate.h>
@interface A2DynamicDelegate : NSProxy
- (id)initWithProtocol:(Protocol *)protocol;
@property (nonatomic, readonly) Protocol *protocol;
@property (nonatomic, strong, readonly) NSMutableDictionary *handlers;
@property (nonatomic, weak, readonly) id realDelegate;
- (id)blockImplementationForMethod:(SEL)selector;
- (void)implementMethod:(SEL)selector withBlock:(id)block;
- (void)removeBlockImplementationForMethod:(SEL)selector;
- (id)blockImplementationForClassMethod:(SEL)selector;
- (void)implementClassMethod:(SEL)selector withBlock:(id)block;
- (void)removeBlockImplementationForClassMethod:(SEL)selector;
@end
