#import <UIKit/UIKit.h>
@interface NSNiceHTNewsWebCell : UITableViewCell
@property (nonatomic, copy) void(^onContentHeightUpdateBlock)(CGFloat height);
- (void)taosetupWithClearHtmlContent:(NSString *)htmlContent;
@end
