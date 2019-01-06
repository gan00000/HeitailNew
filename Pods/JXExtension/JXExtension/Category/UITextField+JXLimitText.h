#import <UIKit/UIKit.h>
@interface UITextField (JXLimitText)
- (UITextPosition *)jx_highlightPosition;
- (void)jx_limitTextWithMaxLength:(NSUInteger)maxLength;
@end
