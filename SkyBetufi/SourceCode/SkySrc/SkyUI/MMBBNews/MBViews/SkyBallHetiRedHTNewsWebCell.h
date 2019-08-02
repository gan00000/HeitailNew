#import <UIKit/UIKit.h>
@interface SkyBallHetiRedHTNewsWebCell : UITableViewCell
@property (nonatomic, copy) void(^onContentHeightUpdateBlock)(CGFloat height);
- (void)waterSkysetupWithClearHtmlContent:(NSString *)htmlContent;
@end
