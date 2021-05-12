#import <Foundation/Foundation.h>
#import "HourseHTCommentModel.h"
NS_ASSUME_NONNULL_BEGIN
@interface HourseHTCommentGetter : NSObject
@property (nonatomic, strong) NSMutableArray<HourseHTCommentModel *> *hotComments;
@property (nonatomic, strong) NSMutableArray<HourseHTCommentModel *> *normalComments;
@property (nonatomic, assign) BOOL hasMore;
- (instancetype)initWithPostId:(NSString *)post_id;
- (void)taodoRequestWithCompleteBlock:(dispatch_block_t)commentBlock;
- (void)taoreset;
@end
NS_ASSUME_NONNULL_END
