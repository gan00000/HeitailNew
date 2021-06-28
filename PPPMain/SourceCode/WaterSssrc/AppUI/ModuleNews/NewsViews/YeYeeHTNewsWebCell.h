#import <UIKit/UIKit.h>
@interface YeYeeHTNewsWebCell : UITableViewCell
@property (nonatomic, copy) void(^onContentHeightUpdateBlock)(CGFloat height);
- (void)taosetupWithClearHtmlContent:(NSString *)htmlContent;
@end
