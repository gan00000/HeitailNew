#import <Foundation/Foundation.h>
#import "SkyBallHetiRedBJHTTPServiceEngine.h"
#import "SkyBallHetiRedHTNewsModel.h"
#import "SkyBallHetiRedHTCommentModel.h"
NS_ASSUME_NONNULL_BEGIN
@interface SkyBallHetiRedHTNewsAdditionRequest : NSObject
+ (void)waterSkyrequestNormalCommentWithOffset:(NSInteger)offset
                                newsId:(NSString *)newsId
                          successBlock:(void(^)(NSArray <SkyBallHetiRedHTCommentModel *> *commentList, NSInteger pages))successBlock
                             failBlock:(BJServiceErrorBlock)failBlock;
+ (void)waterSkyrequestHotCommentWithOffset:(NSInteger)offset
                             newsId:(NSString *)newsId
                       successBlock:(void(^)(NSArray <SkyBallHetiRedHTCommentModel *> *commentList, NSInteger pages))successBlock
                          failBlock:(BJServiceErrorBlock)failBlock;
+ (void)waterSkyrequestAllCommentWithPostId:(NSString *)postId
                       successBlock:(void(^)(NSArray <SkyBallHetiRedHTCommentModel *> *commentList, NSArray<SkyBallHetiRedHTCommentModel *> *hotComments))successBlock
                          failBlock:(BJServiceErrorBlock)failBlock;
+ (void)waterSkyrequestDetailWithPostId:(NSString *)post_id
                   successBlock:(void(^)(SkyBallHetiRedHTNewsModel *newsModel))successBlock
                     errorBlock:(BJServiceErrorBlock)errorBlock;
@end
NS_ASSUME_NONNULL_END
