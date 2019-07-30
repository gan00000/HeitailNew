#import <UIKit/UIKit.h>
@interface XRRFATKHTNewsWebCell : UITableViewCell
@property (nonatomic, copy) void(^onContentHeightUpdateBlock)(CGFloat height);
- (void)skargsetupWithClearHtmlContent:(NSString *)htmlContent;
@end
