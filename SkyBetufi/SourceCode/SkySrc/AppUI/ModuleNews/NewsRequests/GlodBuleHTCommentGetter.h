#import <Foundation/Foundation.h>
#import "GlodBuleHTCommentModel.h"
NS_ASSUME_NONNULL_BEGIN
@interface GlodBuleHTCommentGetter : NSObject
@property (nonatomic, strong) NSMutableArray<GlodBuleHTCommentModel *> *hotComments;
@property (nonatomic, strong) NSMutableArray<GlodBuleHTCommentModel *> *normalComments;
@property (nonatomic, assign) BOOL hasMore;
- (instancetype)initWithPostId:(NSString *)post_id;
- (void)taodoRequestWithCompleteBlock:(dispatch_block_t)commentBlock;
- (void)taoreset;
@end
NS_ASSUME_NONNULL_END
