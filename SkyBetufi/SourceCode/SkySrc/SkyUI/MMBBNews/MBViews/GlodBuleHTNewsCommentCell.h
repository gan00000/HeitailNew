#import <UIKit/UIKit.h>
#import "GlodBuleHTCommentModel.h"
NS_ASSUME_NONNULL_BEGIN
@interface GlodBuleHTNewsCommentCell : UITableViewCell
@property (nonatomic, copy) void (^onReplyBlock)(GlodBuleHTCommentModel *commentModel);
@property (nonatomic, copy) dispatch_block_t onExpendBlock;
- (void)waterSkyrefreshWithCommentModel:(GlodBuleHTCommentModel *)commentModel;
@end
NS_ASSUME_NONNULL_END
