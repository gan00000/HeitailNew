#import "UITextView+JXLimitText.h"
@implementation UITextView (JXLimitText)
- (UITextPosition *)jx_highlightPosition {
    UITextRange *highlightRange = [self markedTextRange];
    UITextPosition *position = [self positionFromPosition:highlightRange.start offset:0];
    return position;
}
- (void)jx_limitTextWithMaxLength:(NSUInteger)maxLength {
    NSString *text = self.text;
    NSString *language = [[UIApplication sharedApplication] textInputMode].primaryLanguage; 
    if ([language isEqualToString:@"zh-Hans"]) { 
        UITextPosition *position = [self jx_highlightPosition];
        if (!position) { 
            if (text.length > maxLength) {
                self.text = [text substringToIndex:maxLength];
            }
        }
    } else {
        if (text.length > maxLength) {
            self.text = [text substringToIndex:maxLength];
        }
    }
}
@end
