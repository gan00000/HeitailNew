#import <UIKit/UIKit.h>
#import "NSNiceHTCommentModel.h"
NS_ASSUME_NONNULL_BEGIN
@interface BByasHTNewsCommentCell : UITableViewCell
@property (nonatomic, copy) void (^onReplyBlock)(NSNiceHTCommentModel *commentModel);
@property (nonatomic, copy) dispatch_block_t onExpendBlock;
- (void)taorefreshWithCommentModel:(NSNiceHTCommentModel *)commentModel;
@end
NS_ASSUME_NONNULL_END
