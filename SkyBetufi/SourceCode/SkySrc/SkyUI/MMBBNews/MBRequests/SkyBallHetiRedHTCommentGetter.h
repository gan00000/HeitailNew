#import <Foundation/Foundation.h>
#import "SkyBallHetiRedHTCommentModel.h"
NS_ASSUME_NONNULL_BEGIN
@interface SkyBallHetiRedHTCommentGetter : NSObject
@property (nonatomic, strong) NSMutableArray<SkyBallHetiRedHTCommentModel *> *hotComments;
@property (nonatomic, strong) NSMutableArray<SkyBallHetiRedHTCommentModel *> *normalComments;
@property (nonatomic, assign) BOOL hasMore;
- (instancetype)initWithPostId:(NSString *)post_id;
- (void)waterSkydoRequestWithCompleteBlock:(dispatch_block_t)commentBlock;
- (void)waterSkyreset;
@end
NS_ASSUME_NONNULL_END
