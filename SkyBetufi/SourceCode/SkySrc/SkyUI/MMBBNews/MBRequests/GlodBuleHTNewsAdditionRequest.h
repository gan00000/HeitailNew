#import <Foundation/Foundation.h>
#import "GlodBuleBJHTTPServiceEngine.h"
#import "GlodBuleHTNewsModel.h"
#import "GlodBuleHTCommentModel.h"
NS_ASSUME_NONNULL_BEGIN
@interface GlodBuleHTNewsAdditionRequest : NSObject
+ (void)waterSkyrequestNormalCommentWithOffset:(NSInteger)offset
                                newsId:(NSString *)newsId
                          successBlock:(void(^)(NSArray <GlodBuleHTCommentModel *> *commentList, NSInteger pages))successBlock
                             failBlock:(BJServiceErrorBlock)failBlock;
+ (void)waterSkyrequestHotCommentWithOffset:(NSInteger)offset
                             newsId:(NSString *)newsId
                       successBlock:(void(^)(NSArray <GlodBuleHTCommentModel *> *commentList, NSInteger pages))successBlock
                          failBlock:(BJServiceErrorBlock)failBlock;
+ (void)waterSkyrequestAllCommentWithPostId:(NSString *)postId
                       successBlock:(void(^)(NSArray <GlodBuleHTCommentModel *> *commentList, NSArray<GlodBuleHTCommentModel *> *hotComments))successBlock
                          failBlock:(BJServiceErrorBlock)failBlock;
+ (void)waterSkyrequestDetailWithPostId:(NSString *)post_id
                   successBlock:(void(^)(GlodBuleHTNewsModel *newsModel))successBlock
                     errorBlock:(BJServiceErrorBlock)errorBlock;
@end
NS_ASSUME_NONNULL_END
