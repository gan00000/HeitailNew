#import <Foundation/Foundation.h>
#import "XRRFATKBJHTTPServiceEngine.h"
#import "XRRFATKHTNewsModel.h"
#import "XRRFATKHTMyMessageModel.h"
NS_ASSUME_NONNULL_BEGIN
typedef void (^HTMyCommentBlock) (NSArray <XRRFATKHTNewsModel *> *newsList, NSInteger pages);
@interface XRRFATKHTUserRequest : NSObject
+ (void)skargdoLoginRequestWithAccessToken:(NSString *)accessToken
                                  sns:(NSInteger)sns
                         successBlock:(void(^)(NSString *userToken))successBlock
                            failBlock:(BJServiceErrorBlock)failBlock;
+ (void)skargrequestUserInfoWithSuccessBlock:(void(^)(NSDictionary *userInfo))successBlock
                              failBlock:(BJServiceErrorBlock)failBlock;
+ (void)skargupdateUserInfoWithEmail:(NSString *)email
                    displayName:(NSString *)displayName
                           file:(NSString *)file
                   successBlock:(void(^)(NSDictionary *userInfo))successBlock
                      failBlock:(BJServiceErrorBlock)failBlock;
+ (void)skargrequestCollectionListWithOffset:(NSInteger)offset
                           successBlock:(HTMyCommentBlock)successBlock
                              failBlock:(BJServiceErrorBlock)failBlock;
+ (void)skargaddCollectionWithNewsId:(NSString *)news_id
                   successBlock:(dispatch_block_t)successBlock
                      failBlock:(BJServiceErrorBlock)failBlock;
+ (void)skargdeleteCollectionWithNewsId:(NSString *)news_id
                      successBlock:(dispatch_block_t)successBlock
                         failBlock:(BJServiceErrorBlock)failBlock;
+ (void)skargrequestHistoryWithOffset:(NSInteger)offset
                    successBlock:(HTMyCommentBlock)successBlock
                       failBlock:(BJServiceErrorBlock)failBlock;
+ (void)skargaddHistoryWithNewsId:(NSString *)news_id
                successBlock:(dispatch_block_t)successBlock
                   failBlock:(BJServiceErrorBlock)failBlock;
+ (void)skargrequestMyCommentWithOffset:(NSInteger)offset
                      successBlock:(HTMyCommentBlock)successBlock
                         failBlock:(BJServiceErrorBlock)failBlock;
+ (void)skargrequestMyLikeWithOffset:(NSInteger)offset
                   successBlock:(HTMyCommentBlock)successBlock
                      failBlock:(BJServiceErrorBlock)failBlock;
+ (void)skargrequestUnReadMessageCountWithSuccessBlock:(void(^)(NSInteger count))successBlock
                                        failBlock:(BJServiceErrorBlock)failBlock;
+ (void)skargrequestMyMessageWithOffset:(NSInteger)offset
                      successBlock:(void(^)(NSArray <XRRFATKHTMyMessageModel *> *messageList, NSInteger pages))successBlock
                         failBlock:(BJServiceErrorBlock)failBlock;
+ (void)skarglikePostWithPostId:(NSString *)post_id
                comment_id:(NSString *)comment_id
                      like:(BOOL)like
              successBlock:(dispatch_block_t)successBlock
                 failBlock:(BJServiceErrorBlock)failBlock;
+ (void)skargpostCommentWithComment_txt:(NSString *)comment_txt
                           post_id:(NSString *)post_id
                  reply_comment_id:(NSString *)reply_comment_id
                      successBlock:(dispatch_block_t)successBlock
                         failBlock:(BJServiceErrorBlock)failBlock;
@end
NS_ASSUME_NONNULL_END
