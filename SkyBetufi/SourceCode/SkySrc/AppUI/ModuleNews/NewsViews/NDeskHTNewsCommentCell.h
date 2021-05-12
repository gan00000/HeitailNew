#import <UIKit/UIKit.h>
#import "HourseHTCommentModel.h"
NS_ASSUME_NONNULL_BEGIN
@interface NDeskHTNewsCommentCell : UITableViewCell
@property (nonatomic, copy) void (^onReplyBlock)(HourseHTCommentModel *commentModel);
@property (nonatomic, copy) dispatch_block_t onExpendBlock;
- (void)taorefreshWithCommentModel:(HourseHTCommentModel *)commentModel;
@end
NS_ASSUME_NONNULL_END
