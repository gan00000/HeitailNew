#import <UIKit/UIKit.h>
@interface HBNewsWebCell : UITableViewCell
@property (nonatomic, copy) void(^onContentHeightUpdateBlock)(CGFloat height);
- (void)setupWithClearHtmlContent:(NSString *)htmlContent;
@end
