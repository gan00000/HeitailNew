//
//  HTLoginRequest.h
//  HeiteBasketball
//
//  Created by 冯生伟 on 2019/4/6.
//  Copyright © 2019 Dean_F. All rights reserved.
//

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

// 獲取我的收藏
+ (void)skargrequestCollectionListWithOffset:(NSInteger)offset
                           successBlock:(HTMyCommentBlock)successBlock
                              failBlock:(BJServiceErrorBlock)failBlock;

// 添加收藏
+ (void)skargaddCollectionWithNewsId:(NSString *)news_id
                   successBlock:(dispatch_block_t)successBlock
                      failBlock:(BJServiceErrorBlock)failBlock;

// 取消收藏
+ (void)skargdeleteCollectionWithNewsId:(NSString *)news_id
                      successBlock:(dispatch_block_t)successBlock
                         failBlock:(BJServiceErrorBlock)failBlock;

// 獲取瀏覽歷史
+ (void)skargrequestHistoryWithOffset:(NSInteger)offset
                    successBlock:(HTMyCommentBlock)successBlock
                       failBlock:(BJServiceErrorBlock)failBlock;

// 添加瀏覽歷史
+ (void)skargaddHistoryWithNewsId:(NSString *)news_id
                successBlock:(dispatch_block_t)successBlock
                   failBlock:(BJServiceErrorBlock)failBlock;

// 獲取我的留言
+ (void)skargrequestMyCommentWithOffset:(NSInteger)offset
                      successBlock:(HTMyCommentBlock)successBlock
                         failBlock:(BJServiceErrorBlock)failBlock;

// 獲取我的點讚
+ (void)skargrequestMyLikeWithOffset:(NSInteger)offset
                   successBlock:(HTMyCommentBlock)successBlock
                      failBlock:(BJServiceErrorBlock)failBlock;

// 獲取未讀消息數
+ (void)skargrequestUnReadMessageCountWithSuccessBlock:(void(^)(NSInteger count))successBlock
                                        failBlock:(BJServiceErrorBlock)failBlock;

// 獲取消息通知列表
+ (void)skargrequestMyMessageWithOffset:(NSInteger)offset
                      successBlock:(void(^)(NSArray <XRRFATKHTMyMessageModel *> *messageList, NSInteger pages))successBlock
                         failBlock:(BJServiceErrorBlock)failBlock;

// 點讚/取消點讚
+ (void)skarglikePostWithPostId:(NSString *)post_id
                comment_id:(NSString *)comment_id
                      like:(BOOL)like
              successBlock:(dispatch_block_t)successBlock
                 failBlock:(BJServiceErrorBlock)failBlock;

// 發表評論
+ (void)skargpostCommentWithComment_txt:(NSString *)comment_txt
                           post_id:(NSString *)post_id
                  reply_comment_id:(NSString *)reply_comment_id
                      successBlock:(dispatch_block_t)successBlock
                         failBlock:(BJServiceErrorBlock)failBlock;

@end

NS_ASSUME_NONNULL_END
