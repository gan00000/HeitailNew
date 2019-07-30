#import <UIKit/UIKit.h>
#import "XRRFATKHTCommentModel.h"
NS_ASSUME_NONNULL_BEGIN
@interface XRRFATKHTNewsCommentCell : UITableViewCell
@property (nonatomic, copy) void (^onReplyBlock)(XRRFATKHTCommentModel *commentModel);
@property (nonatomic, copy) dispatch_block_t onExpendBlock;
- (void)skargrefreshWithCommentModel:(XRRFATKHTCommentModel *)commentModel;
@end
NS_ASSUME_NONNULL_END
