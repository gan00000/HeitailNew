#import <UIKit/UIKit.h>
@interface UITextView (JXLimitText)
- (UITextPosition *)jx_highlightPosition;
- (void)jx_limitTextWithMaxLength:(NSUInteger)maxLength;
@end
