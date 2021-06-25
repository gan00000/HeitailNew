#import <Foundation/Foundation.h>
#import "NSNiceBJHTTPServiceEngine.h"
#import "CfipyHTNewsModel.h"
#import "YeYeeHTMyMessageModel.h"
#import "YeYeeHTUpdateInfoModel.h"

NS_ASSUME_NONNULL_BEGIN
typedef void (^HTMyCommentBlock) (NSArray <CfipyHTNewsModel *> *newsList, NSInteger pages);
@interface NSNiceHTUserRequest : NSObject

+ (void)taodoCheckAppUpdateWithSuccessBlock:(void(^)(YeYeeHTUpdateInfoModel *kHTUpdateInfoModel))successBlock
                                  failBlock:(BJServiceErrorBlock)failBlock;

+ (void)taodoLoginRequestWithAccessToken:(NSString *)accessToken
                                  sns:(NSInteger)sns
                         successBlock:(void(^)(NSString *userToken))successBlock
                            failBlock:(BJServiceErrorBlock)failBlock;

+ (void)doThirdLoginRequestWithAccessToken:(NSString *)accessToken
         sns:(NSInteger)sns
           userId:(NSString *)userId
       nickName:(NSString *)nickName
       email:(NSString *)email
successBlock:(void(^)(NSString *userToken))successBlock
                                 failBlock:(BJServiceErrorBlock)failBlock;

+ (void)taorequestUserInfoWithSuccessBlock:(void(^)(NSDictionary *userInfo))successBlock
                              failBlock:(BJServiceErrorBlock)failBlock;
+ (void)taoupdateUserInfoWithEmail:(NSString *)email
                    displayName:(NSString *)displayName
                           file:(NSString *)file
                   successBlock:(void(^)(NSDictionary *userInfo))successBlock
                      failBlock:(BJServiceErrorBlock)failBlock;
+ (void)taorequestCollectionListWithOffset:(NSInteger)offset
                           successBlock:(HTMyCommentBlock)successBlock
                              failBlock:(BJServiceErrorBlock)failBlock;
+ (void)taoaddCollectionWithNewsId:(NSString *)news_id
                   successBlock:(dispatch_block_t)successBlock
                      failBlock:(BJServiceErrorBlock)failBlock;
+ (void)taodeleteCollectionWithNewsId:(NSString *)news_id
                      successBlock:(dispatch_block_t)successBlock
                         failBlock:(BJServiceErrorBlock)failBlock;
+ (void)taorequestHistoryWithOffset:(NSInteger)offset
                    successBlock:(HTMyCommentBlock)successBlock
                       failBlock:(BJServiceErrorBlock)failBlock;
+ (void)taoaddHistoryWithNewsId:(NSString *)news_id
                successBlock:(dispatch_block_t)successBlock
                   failBlock:(BJServiceErrorBlock)failBlock;
+ (void)taorequestMyCommentWithOffset:(NSInteger)offset
                      successBlock:(HTMyCommentBlock)successBlock
                         failBlock:(BJServiceErrorBlock)failBlock;
+ (void)taorequestMyLikeWithOffset:(NSInteger)offset
                   successBlock:(HTMyCommentBlock)successBlock
                      failBlock:(BJServiceErrorBlock)failBlock;
+ (void)taorequestUnReadMessageCountWithSuccessBlock:(void(^)(NSInteger count))successBlock
                                        failBlock:(BJServiceErrorBlock)failBlock;
+ (void)taorequestMyMessageWithOffset:(NSInteger)offset
                      successBlock:(void(^)(NSArray <YeYeeHTMyMessageModel *> *messageList, NSInteger pages))successBlock
                         failBlock:(BJServiceErrorBlock)failBlock;
+ (void)taolikePostWithPostId:(NSString *)post_id
                comment_id:(NSString *)comment_id
                      like:(BOOL)like
              successBlock:(dispatch_block_t)successBlock
                 failBlock:(BJServiceErrorBlock)failBlock;
+ (void)taopostCommentWithComment_txt:(NSString *)comment_txt
                           post_id:(NSString *)post_id
                  reply_comment_id:(NSString *)reply_comment_id
                      successBlock:(dispatch_block_t)successBlock
                         failBlock:(BJServiceErrorBlock)failBlock;

+ (void)taoaddLikeWithNewsId:(NSString *)news_id successBlock:(dispatch_block_t)successBlock failBlock:(BJServiceErrorBlock)failBlock;

+ (void)taodeleteLikeWithNewsId:(NSString *)news_id successBlock:(dispatch_block_t)successBlock failBlock:(BJServiceErrorBlock)failBlock;

@end
NS_ASSUME_NONNULL_END
