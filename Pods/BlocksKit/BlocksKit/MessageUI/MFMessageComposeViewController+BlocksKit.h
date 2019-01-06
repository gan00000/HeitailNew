#import <MessageUI/MessageUI.h>
@interface MFMessageComposeViewController (BlocksKit)
@property (nonatomic, copy, setter = bk_setCompletionBlock:) void (^bk_completionBlock)(MFMessageComposeViewController *controller, MessageComposeResult result);
@end
