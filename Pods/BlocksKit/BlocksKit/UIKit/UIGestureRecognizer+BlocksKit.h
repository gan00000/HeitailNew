#import <UIKit/UIKit.h>
@interface UIGestureRecognizer (BlocksKit)
+ (id)bk_recognizerWithHandler:(void (^)(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location))block delay:(NSTimeInterval)delay;
- (id)bk_initWithHandler:(void (^)(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location))block delay:(NSTimeInterval)delay NS_REPLACES_RECEIVER;
+ (id)bk_recognizerWithHandler:(void (^)(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location))block;
- (id)bk_initWithHandler:(void (^)(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location))block NS_REPLACES_RECEIVER;
@property (nonatomic, copy, setter = bk_setHandler:) void (^bk_handler)(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location);
@property (nonatomic, setter = bk_setHandlerDelay:) NSTimeInterval bk_handlerDelay;
- (void)bk_cancel;
@end
