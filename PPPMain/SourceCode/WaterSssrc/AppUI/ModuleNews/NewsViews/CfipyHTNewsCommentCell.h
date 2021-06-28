#import <UIKit/UIKit.h>
#import "WSKggHTCommentModel.h"
NS_ASSUME_NONNULL_BEGIN
@interface CfipyHTNewsCommentCell : UITableViewCell
@property (nonatomic, copy) void (^onReplyBlock)(WSKggHTCommentModel *commentModel);
@property (nonatomic, copy) dispatch_block_t onExpendBlock;
- (void)taorefreshWithCommentModel:(WSKggHTCommentModel *)commentModel;
@end
NS_ASSUME_NONNULL_END
