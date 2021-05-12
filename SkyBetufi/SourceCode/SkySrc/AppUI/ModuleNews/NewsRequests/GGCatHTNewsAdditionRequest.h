#import <Foundation/Foundation.h>
#import "PXFunBJHTTPServiceEngine.h"
#import "PXFunHTNewsModel.h"
#import "HourseHTCommentModel.h"
NS_ASSUME_NONNULL_BEGIN
@interface GGCatHTNewsAdditionRequest : NSObject
+ (void)taorequestNormalCommentWithOffset:(NSInteger)offset
                                newsId:(NSString *)newsId
                          successBlock:(void(^)(NSArray <HourseHTCommentModel *> *commentList, NSInteger pages))successBlock
                             failBlock:(BJServiceErrorBlock)failBlock;
+ (void)taorequestHotCommentWithOffset:(NSInteger)offset
                             newsId:(NSString *)newsId
                       successBlock:(void(^)(NSArray <HourseHTCommentModel *> *commentList, NSInteger pages))successBlock
                          failBlock:(BJServiceErrorBlock)failBlock;
+ (void)taorequestAllCommentWithPostId:(NSString *)postId
                       successBlock:(void(^)(NSArray <HourseHTCommentModel *> *commentList, NSArray<HourseHTCommentModel *> *hotComments))successBlock
                          failBlock:(BJServiceErrorBlock)failBlock;
+ (void)taorequestDetailWithPostId:(NSString *)post_id
                   successBlock:(void(^)(PXFunHTNewsModel *newsModel))successBlock
                     errorBlock:(BJServiceErrorBlock)errorBlock;
@end
NS_ASSUME_NONNULL_END
