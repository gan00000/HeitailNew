#import <Foundation/Foundation.h>
#import "SkyBallHetiRedBJHTTPServiceEngine.h"
#import "SkyBallHetiRedHTNewsModel.h"
#import "SkyBallHetiRedHTMyMessageModel.h"
NS_ASSUME_NONNULL_BEGIN
typedef void (^HTMyCommentBlock) (NSArray <SkyBallHetiRedHTNewsModel *> *newsList, NSInteger pages);
@interface SkyBallHetiRedHTUserRequest : NSObject
+ (void)waterSkydoLoginRequestWithAccessToken:(NSString *)accessToken
                                  sns:(NSInteger)sns
                         successBlock:(void(^)(NSString *userToken))successBlock
                            failBlock:(BJServiceErrorBlock)failBlock;
+ (void)waterSkyrequestUserInfoWithSuccessBlock:(void(^)(NSDictionary *userInfo))successBlock
                              failBlock:(BJServiceErrorBlock)failBlock;
+ (void)waterSkyupdateUserInfoWithEmail:(NSString *)email
                    displayName:(NSString *)displayName
                           file:(NSString *)file
                   successBlock:(void(^)(NSDictionary *userInfo))successBlock
                      failBlock:(BJServiceErrorBlock)failBlock;
+ (void)waterSkyrequestCollectionListWithOffset:(NSInteger)offset
                           successBlock:(HTMyCommentBlock)successBlock
                              failBlock:(BJServiceErrorBlock)failBlock;
+ (void)waterSkyaddCollectionWithNewsId:(NSString *)news_id
                   successBlock:(dispatch_block_t)successBlock
                      failBlock:(BJServiceErrorBlock)failBlock;
+ (void)waterSkydeleteCollectionWithNewsId:(NSString *)news_id
                      successBlock:(dispatch_block_t)successBlock
                         failBlock:(BJServiceErrorBlock)failBlock;
+ (void)waterSkyrequestHistoryWithOffset:(NSInteger)offset
                    successBlock:(HTMyCommentBlock)successBlock
                       failBlock:(BJServiceErrorBlock)failBlock;
+ (void)waterSkyaddHistoryWithNewsId:(NSString *)news_id
                successBlock:(dispatch_block_t)successBlock
                   failBlock:(BJServiceErrorBlock)failBlock;
+ (void)waterSkyrequestMyCommentWithOffset:(NSInteger)offset
                      successBlock:(HTMyCommentBlock)successBlock
                         failBlock:(BJServiceErrorBlock)failBlock;
+ (void)waterSkyrequestMyLikeWithOffset:(NSInteger)offset
                   successBlock:(HTMyCommentBlock)successBlock
                      failBlock:(BJServiceErrorBlock)failBlock;
+ (void)waterSkyrequestUnReadMessageCountWithSuccessBlock:(void(^)(NSInteger count))successBlock
                                        failBlock:(BJServiceErrorBlock)failBlock;
+ (void)waterSkyrequestMyMessageWithOffset:(NSInteger)offset
                      successBlock:(void(^)(NSArray <SkyBallHetiRedHTMyMessageModel *> *messageList, NSInteger pages))successBlock
                         failBlock:(BJServiceErrorBlock)failBlock;
+ (void)waterSkylikePostWithPostId:(NSString *)post_id
                comment_id:(NSString *)comment_id
                      like:(BOOL)like
              successBlock:(dispatch_block_t)successBlock
                 failBlock:(BJServiceErrorBlock)failBlock;
+ (void)waterSkypostCommentWithComment_txt:(NSString *)comment_txt
                           post_id:(NSString *)post_id
                  reply_comment_id:(NSString *)reply_comment_id
                      successBlock:(dispatch_block_t)successBlock
                         failBlock:(BJServiceErrorBlock)failBlock;
@end
NS_ASSUME_NONNULL_END
