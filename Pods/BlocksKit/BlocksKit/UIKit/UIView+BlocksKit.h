#import <UIKit/UIKit.h>
@interface UIView (BlocksKit)
- (void)bk_whenTouches:(NSUInteger)numberOfTouches tapped:(NSUInteger)numberOfTaps handler:(void (^)(void))block;
- (void)bk_whenTapped:(void (^)(void))block;
- (void)bk_whenDoubleTapped:(void (^)(void))block;
- (void)bk_eachSubview:(void (^)(UIView *subview))block;
@end
