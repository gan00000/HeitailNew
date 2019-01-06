#import <UIKit/UIKit.h>
@interface UIBarButtonItem (BlocksKit)
- (id)bk_initWithBarButtonSystemItem:(UIBarButtonSystemItem)systemItem handler:(void (^)(id sender))action NS_REPLACES_RECEIVER;
- (id)bk_initWithImage:(UIImage *)image style:(UIBarButtonItemStyle)style handler:(void (^)(id sender))action NS_REPLACES_RECEIVER;
- (id)bk_initWithImage:(UIImage *)image landscapeImagePhone:(UIImage *)landscapeImagePhone style:(UIBarButtonItemStyle)style handler:(void (^)(id sender))action NS_REPLACES_RECEIVER NS_AVAILABLE_IOS(5_0);
- (id)bk_initWithTitle:(NSString *)title style:(UIBarButtonItemStyle)style handler:(void (^)(id sender))action NS_REPLACES_RECEIVER;
@end
