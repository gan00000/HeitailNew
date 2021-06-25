#import <Foundation/Foundation.h>
#import "BlysaBJHTTPServiceEngine.h"
#import "UUaksHTNewsModel.h"
#import "NSNiceHTCommentModel.h"
NS_ASSUME_NONNULL_BEGIN
@interface YeYeeHTNewsAdditionRequest : NSObject
+ (void)taorequestNormalCommentWithOffset:(NSInteger)offset
                                newsId:(NSString *)newsId
                          successBlock:(void(^)(NSArray <NSNiceHTCommentModel *> *commentList, NSInteger pages))successBlock
                             failBlock:(BJServiceErrorBlock)failBlock;
+ (void)taorequestHotCommentWithOffset:(NSInteger)offset
                             newsId:(NSString *)newsId
                       successBlock:(void(^)(NSArray <NSNiceHTCommentModel *> *commentList, NSInteger pages))successBlock
                          failBlock:(BJServiceErrorBlock)failBlock;
+ (void)taorequestAllCommentWithPostId:(NSString *)postId
                       successBlock:(void(^)(NSArray <NSNiceHTCommentModel *> *commentList, NSArray<NSNiceHTCommentModel *> *hotComments))successBlock
                          failBlock:(BJServiceErrorBlock)failBlock;
+ (void)taorequestDetailWithPostId:(NSString *)post_id
                   successBlock:(void(^)(UUaksHTNewsModel *newsModel))successBlock
                     errorBlock:(BJServiceErrorBlock)errorBlock;
@end
NS_ASSUME_NONNULL_END
