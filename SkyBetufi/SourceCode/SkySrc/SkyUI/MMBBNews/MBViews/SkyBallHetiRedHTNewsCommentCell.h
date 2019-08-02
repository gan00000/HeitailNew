#import <UIKit/UIKit.h>
#import "SkyBallHetiRedHTCommentModel.h"
NS_ASSUME_NONNULL_BEGIN
@interface SkyBallHetiRedHTNewsCommentCell : UITableViewCell
@property (nonatomic, copy) void (^onReplyBlock)(SkyBallHetiRedHTCommentModel *commentModel);
@property (nonatomic, copy) dispatch_block_t onExpendBlock;
- (void)waterSkyrefreshWithCommentModel:(SkyBallHetiRedHTCommentModel *)commentModel;
@end
NS_ASSUME_NONNULL_END
