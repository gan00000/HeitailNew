#import <Foundation/Foundation.h>
#import "NSNiceHTCommentModel.h"
NS_ASSUME_NONNULL_BEGIN
@interface YeYeeHTCommentGetter : NSObject
@property (nonatomic, strong) NSMutableArray<NSNiceHTCommentModel *> *hotComments;
@property (nonatomic, strong) NSMutableArray<NSNiceHTCommentModel *> *normalComments;
@property (nonatomic, assign) BOOL hasMore;
- (instancetype)initWithPostId:(NSString *)post_id;
- (void)taodoRequestWithCompleteBlock:(dispatch_block_t)commentBlock;
- (void)taoreset;
@end
NS_ASSUME_NONNULL_END
