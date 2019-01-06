#import <UIKit/UIKit.h>
@interface UIControl (BlocksKit)
- (void)bk_addEventHandler:(void (^)(id sender))handler forControlEvents:(UIControlEvents)controlEvents;
- (void)bk_removeEventHandlersForControlEvents:(UIControlEvents)controlEvents;
- (BOOL)bk_hasEventHandlersForControlEvents:(UIControlEvents)controlEvents;
@end
