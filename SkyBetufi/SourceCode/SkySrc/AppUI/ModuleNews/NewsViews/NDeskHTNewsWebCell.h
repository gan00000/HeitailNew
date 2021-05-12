#import <UIKit/UIKit.h>
@interface NDeskHTNewsWebCell : UITableViewCell
@property (nonatomic, copy) void(^onContentHeightUpdateBlock)(CGFloat height);
- (void)taosetupWithClearHtmlContent:(NSString *)htmlContent;
@end
