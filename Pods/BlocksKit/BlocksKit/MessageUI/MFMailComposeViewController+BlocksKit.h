#import <MessageUI/MessageUI.h>
@interface MFMailComposeViewController (BlocksKit)
@property (nonatomic, copy, setter = bk_setCompletionBlock:) void (^bk_completionBlock)(MFMailComposeViewController *controller, MFMailComposeResult result, NSError *error);
@end
