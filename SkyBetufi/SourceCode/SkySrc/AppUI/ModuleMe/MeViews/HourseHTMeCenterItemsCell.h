#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
@interface HourseHTMeCenterItemsCell : UITableViewCell
@property (nonatomic, copy) void (^onItemTappedBlock)(NSInteger index);
@end
NS_ASSUME_NONNULL_END
