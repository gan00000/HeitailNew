#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
@interface UUaksHTCommentExpendCell : UITableViewCell
@property (nonatomic, copy) void (^onExpendChangeBlock)(BOOL expend);
@end
NS_ASSUME_NONNULL_END