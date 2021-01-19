#import <UIKit/UIKit.h>
@interface GlodBuleHTNewsWebCell : UITableViewCell
@property (nonatomic, copy) void(^onContentHeightUpdateBlock)(CGFloat height);
- (void)taosetupWithClearHtmlContent:(NSString *)htmlContent;
@end
