#import <Foundation/Foundation.h>
#import "XRRFATKBJHTTPServiceEngine.h"
#import "XRRFATKHTNewsModel.h"
#import "XRRFATKHTCommentModel.h"
NS_ASSUME_NONNULL_BEGIN
@interface XRRFATKHTNewsAdditionRequest : NSObject
+ (void)skargrequestNormalCommentWithOffset:(NSInteger)offset
                                newsId:(NSString *)newsId
                          successBlock:(void(^)(NSArray <XRRFATKHTCommentModel *> *commentList, NSInteger pages))successBlock
                             failBlock:(BJServiceErrorBlock)failBlock;
+ (void)skargrequestHotCommentWithOffset:(NSInteger)offset
                             newsId:(NSString *)newsId
                       successBlock:(void(^)(NSArray <XRRFATKHTCommentModel *> *commentList, NSInteger pages))successBlock
                          failBlock:(BJServiceErrorBlock)failBlock;
+ (void)skargrequestAllCommentWithPostId:(NSString *)postId
                       successBlock:(void(^)(NSArray <XRRFATKHTCommentModel *> *commentList, NSArray<XRRFATKHTCommentModel *> *hotComments))successBlock
                          failBlock:(BJServiceErrorBlock)failBlock;
+ (void)skargrequestDetailWithPostId:(NSString *)post_id
                   successBlock:(void(^)(XRRFATKHTNewsModel *newsModel))successBlock
                     errorBlock:(BJServiceErrorBlock)errorBlock;
@end
NS_ASSUME_NONNULL_END
