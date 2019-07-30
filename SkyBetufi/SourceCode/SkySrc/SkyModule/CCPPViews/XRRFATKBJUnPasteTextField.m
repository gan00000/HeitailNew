#import "XRRFATKBJUnPasteTextField.h"
@implementation XRRFATKBJUnPasteTextField
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if (action == @selector(paste:))
        return NO;
    if (action == @selector(select:))
        return NO;
    if (action == @selector(selectAll:))
        return NO;
    return [super canPerformAction:action withSender:sender];
}
@end
