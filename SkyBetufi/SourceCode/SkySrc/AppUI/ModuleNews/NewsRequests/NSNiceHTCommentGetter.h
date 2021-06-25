#import <Foundation/Foundation.h>
#import "WSKggHTCommentModel.h"
NS_ASSUME_NONNULL_BEGIN
@interface NSNiceHTCommentGetter : NSObject
@property (nonatomic, strong) NSMutableArray<WSKggHTCommentModel *> *hotComments;
@property (nonatomic, strong) NSMutableArray<WSKggHTCommentModel *> *normalComments;
@property (nonatomic, assign) BOOL hasMore;
- (instancetype)initWithPostId:(NSString *)post_id;
- (void)taodoRequestWithCompleteBlock:(dispatch_block_t)commentBlock;
- (void)taoreset;
@end
NS_ASSUME_NONNULL_END
