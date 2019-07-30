#import <Foundation/Foundation.h>
#import "XRRFATKHTCommentModel.h"
NS_ASSUME_NONNULL_BEGIN
@interface XRRFATKHTCommentGetter : NSObject
@property (nonatomic, strong) NSMutableArray<XRRFATKHTCommentModel *> *hotComments;
@property (nonatomic, strong) NSMutableArray<XRRFATKHTCommentModel *> *normalComments;
@property (nonatomic, assign) BOOL hasMore;
- (instancetype)initWithPostId:(NSString *)post_id;
- (void)skargdoRequestWithCompleteBlock:(dispatch_block_t)commentBlock;
- (void)skargreset;
@end
NS_ASSUME_NONNULL_END
