#import <UIKit/UIKit.h>
#import "UIView+QuickFrame.h"

@interface UIView (QuickFrameMixcode)
- (void)setX:(CGFloat)x mixcode:(NSString *)mixcode;
- (void)setY:(CGFloat)y mixcode:(NSString *)mixcode;
- (void)setWidth:(CGFloat)width mixcode:(NSString *)mixcode;
- (void)setHeight:(CGFloat)height mixcode:(NSString *)mixcode;
- (void)setOrigin:(CGPoint)origin mixcode:(NSString *)mixcode;
- (void)setSize:(CGSize)size mixcode:(NSString *)mixcode;
- (void)setRight:(CGFloat)right mixcode:(NSString *)mixcode;
- (void)setBottom:(CGFloat)bottom mixcode:(NSString *)mixcode;
- (void)setCenterX:(CGFloat)centerX mixcode:(NSString *)mixcode;
- (void)setCenterY:(CGFloat)centerY mixcode:(NSString *)mixcode;
- (void)xMixcode:(NSString *)mixcode;
- (void)yMixcode:(NSString *)mixcode;
- (void)widthMixcode:(NSString *)mixcode;
- (void)heightMixcode:(NSString *)mixcode;
- (void)originMixcode:(NSString *)mixcode;
- (void)sizeMixcode:(NSString *)mixcode;
- (void)rightMixcode:(NSString *)mixcode;
- (void)bottomMixcode:(NSString *)mixcode;
- (void)centerXMixcode:(NSString *)mixcode;
- (void)centerYMixcode:(NSString *)mixcode;

@end
