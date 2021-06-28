#import <Foundation/Foundation.h>
#import "NSNiceBJHTTPServiceEngine.h"
#import "CfipyHTNewsModel.h"
#import "WSKggHTCommentModel.h"
NS_ASSUME_NONNULL_BEGIN
@interface FFlaliHTNewsAdditionRequest : NSObject
+ (void)taorequestNormalCommentWithOffset:(NSInteger)offset
                                newsId:(NSString *)newsId
                          successBlock:(void(^)(NSArray <WSKggHTCommentModel *> *commentList, NSInteger pages))successBlock
                             failBlock:(BJServiceErrorBlock)failBlock;
+ (void)taorequestHotCommentWithOffset:(NSInteger)offset
                             newsId:(NSString *)newsId
                       successBlock:(void(^)(NSArray <WSKggHTCommentModel *> *commentList, NSInteger pages))successBlock
                          failBlock:(BJServiceErrorBlock)failBlock;
+ (void)taorequestAllCommentWithPostId:(NSString *)postId
                       successBlock:(void(^)(NSArray <WSKggHTCommentModel *> *commentList, NSArray<WSKggHTCommentModel *> *hotComments))successBlock
                          failBlock:(BJServiceErrorBlock)failBlock;
+ (void)taorequestDetailWithPostId:(NSString *)post_id
                   successBlock:(void(^)(CfipyHTNewsModel *newsModel))successBlock
                     errorBlock:(BJServiceErrorBlock)errorBlock;
@end
NS_ASSUME_NONNULL_END
