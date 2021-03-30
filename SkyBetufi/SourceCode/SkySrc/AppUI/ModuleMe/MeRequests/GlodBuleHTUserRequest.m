#import "GlodBuleHTUserRequest.h"
@implementation GlodBuleHTUserRequest
+ (void)taodoLoginRequestWithAccessToken:(NSString *)accessToken
                                  sns:(NSInteger)sns
                         successBlock:(void(^)(NSString *userToken))successBlock
                            failBlock:(BJServiceErrorBlock)failBlock {
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"sns_login"] = @(sns);
    param[@"access_token"] = accessToken;
    param[@"device_token"] = [GlodBuleHTUserManager tao_deviceToken];
    param[@"device_type"] = @(1);
    [GlodBuleBJHTTPServiceEngine tao_postRequestWithFunctionPath:API_USER_LOGIN params:param successBlock:^(id responseData) {
        if (successBlock) {
            successBlock(responseData[@"result"][@"user_token"]);
        }
    } errorBlock:failBlock];
}

+ (void)doThirdLoginRequestWithAccessToken:(NSString *)accessToken
                                  sns:(NSInteger)sns
                                    userId:(NSString *)userId
                                nickName:(NSString *)nickName
                                email:(NSString *)email
                         successBlock:(void(^)(NSString *userToken))successBlock
                            failBlock:(BJServiceErrorBlock)failBlock {
    
    if (!nickName) {
        nickName = @"";
    }
    if (!email) {
          email = @"";
      }
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"sns_login"] = @(sns);
    param[@"name"] = nickName;
    param[@"user_id"] = userId;
    param[@"email"] = email;
    param[@"access_token"] = accessToken;
    param[@"device_token"] = [GlodBuleHTUserManager tao_deviceToken];
    param[@"device_type"] = @(1);
    BJLog(@"login params: %@", param);
    [GlodBuleBJHTTPServiceEngine tao_postRequestWithFunctionPath:API_USER_LOGIN params:param successBlock:^(id responseData) {
        if (successBlock) {
            successBlock(responseData[@"result"][@"user_token"]);
        }
    } errorBlock:failBlock];
}

+ (void)taorequestUserInfoWithSuccessBlock:(void(^)(NSDictionary *userInfo))successBlock
                              failBlock:(BJServiceErrorBlock)failBlock {
    [GlodBuleBJHTTPServiceEngine tao_getRequestWithFunctionPath:API_USER_INFO params:nil successBlock:^(id responseData) {
        if (successBlock) {
            successBlock(responseData[@"result"]);
        }
    } errorBlock:failBlock];
}
+ (void)taoupdateUserInfoWithEmail:(NSString *)email
                    displayName:(NSString *)displayName
                           file:(NSString *)file
                   successBlock:(void(^)(NSDictionary *userInfo))successBlock
                      failBlock:(BJServiceErrorBlock)failBlock {
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"email"] = email;
    param[@"display_name"] = displayName;
    param[@"file"] = file;
    [GlodBuleBJHTTPServiceEngine tao_postRequestWithFunctionPath:API_USER_UPDATE params:param successBlock:^(id responseData) {
        if (successBlock) {
            successBlock(responseData[@"result"]);
        }
    } errorBlock:failBlock];
}
+ (void)taorequestCollectionListWithOffset:(NSInteger)offset successBlock:(void(^)(NSArray <GlodBuleHTNewsModel *> *newsList, NSInteger pages))successBlock failBlock:(BJServiceErrorBlock)failBlock {
    [GlodBuleBJHTTPServiceEngine tao_postRequestWithFunctionPath:API_USER_SAVE_LIST params:@{@"offset": @(offset)} successBlock:^(id responseData) {
        if (successBlock) {
            successBlock([NSArray yy_modelArrayWithClass:[GlodBuleHTNewsModel class] json:responseData[@"savedposts"][@"posts"]], [(NSNumber *)responseData[@"savedposts"][@"pages"] integerValue]);
        }
    } errorBlock:failBlock];
}
+ (void)taoaddCollectionWithNewsId:(NSString *)news_id successBlock:(dispatch_block_t)successBlock failBlock:(BJServiceErrorBlock)failBlock {
    [GlodBuleBJHTTPServiceEngine tao_postRequestWithFunctionPath:API_USER_SAVE_ADD params:@{@"post_id": news_id} successBlock:^(id responseData) {
        if (successBlock) {
            successBlock();
        }
    } errorBlock:failBlock];
}
+ (void)taodeleteCollectionWithNewsId:(NSString *)news_id successBlock:(dispatch_block_t)successBlock failBlock:(BJServiceErrorBlock)failBlock {
    [GlodBuleBJHTTPServiceEngine tao_postRequestWithFunctionPath:API_USER_UNSAVE params:@{@"post_id": news_id} successBlock:^(id responseData) {
        if (successBlock) {
            successBlock();
        }
    } errorBlock:failBlock];
}
+ (void)taorequestHistoryWithOffset:(NSInteger)offset
                    successBlock:(HTMyCommentBlock)successBlock
                       failBlock:(BJServiceErrorBlock)failBlock {
    [GlodBuleBJHTTPServiceEngine tao_postRequestWithFunctionPath:API_USER_HISTORY_LIST params:@{@"offset": @(offset)} successBlock:^(id responseData) {
        if (successBlock) {
            NSArray *list = [NSArray yy_modelArrayWithClass:[GlodBuleHTNewsModel class] json:responseData[@"historyposts"][@"posts"]];
            NSInteger pages = [(NSNumber *)responseData[@"historyposts"][@"pages"] integerValue];
            successBlock(list, pages);
        }
    } errorBlock:failBlock];
}
+ (void)taoaddHistoryWithNewsId:(NSString *)news_id successBlock:(dispatch_block_t)successBlock failBlock:(BJServiceErrorBlock)failBlock {
    [GlodBuleBJHTTPServiceEngine tao_postRequestWithFunctionPath:API_USER_HISTORY_ADD params:@{@"post_id": news_id} successBlock:^(id responseData) {
        if (successBlock) {
            successBlock();
        }
    } errorBlock:failBlock];
}
+ (void)taorequestMyCommentWithOffset:(NSInteger)offset successBlock:(void(^)(NSArray <GlodBuleHTNewsModel *> *newsList, NSInteger pages))successBlock failBlock:(BJServiceErrorBlock)failBlock {
    [GlodBuleBJHTTPServiceEngine tao_postRequestWithFunctionPath:API_USER_MY_COMMENT params:@{@"offset": @(offset)} successBlock:^(id responseData) {
        if (successBlock) {
            NSArray *newsList = [NSArray yy_modelArrayWithClass:[GlodBuleHTNewsModel class] json:responseData[@"savedposts"][@"comments"]];
            NSInteger pages = [(NSNumber *)responseData[@"savedposts"][@"pages"] integerValue];
            successBlock(newsList, pages);
        }
    } errorBlock:failBlock];
}
+ (void)taorequestMyLikeWithOffset:(NSInteger)offset successBlock:(void(^)(NSArray <GlodBuleHTNewsModel *> *newsList, NSInteger pages))successBlock failBlock:(BJServiceErrorBlock)failBlock {
    [GlodBuleBJHTTPServiceEngine tao_postRequestWithFunctionPath:API_USER_MY_LIKE params:@{@"offset": @(offset)} successBlock:^(id responseData) {
        if (successBlock) {
            NSArray *newsList = [NSArray yy_modelArrayWithClass:[GlodBuleHTNewsModel class] json:responseData[@"savedposts"][@"comments"]];
            NSInteger pages = [(NSNumber *)responseData[@"savedposts"][@"pages"] integerValue];
            successBlock(newsList, pages);
        }
    } errorBlock:failBlock];
}
+ (void)taorequestUnReadMessageCountWithSuccessBlock:(void(^)(NSInteger count))successBlock failBlock:(BJServiceErrorBlock)failBlock {
    [GlodBuleBJHTTPServiceEngine tao_postRequestWithFunctionPath:API_USER_MESSAGE_COUNT params:nil successBlock:^(id responseData) {
        if (successBlock) {
            successBlock([(NSString *)responseData[@"result"][@"total_unread"] integerValue]);
        }
    } errorBlock:failBlock];
}
+ (void)taorequestMyMessageWithOffset:(NSInteger)offset
                      successBlock:(void(^)(NSArray <GlodBuleHTMyMessageModel *> *messageList, NSInteger pages))successBlock
                         failBlock:(BJServiceErrorBlock)failBlock {
    [GlodBuleBJHTTPServiceEngine tao_postRequestWithFunctionPath:API_USER_MESSAGE_LIST params:@{@"offset": @(offset)} successBlock:^(id responseData) {
        if (successBlock) {
            NSArray *list = [NSArray yy_modelArrayWithClass:[GlodBuleHTMyMessageModel class] json:responseData[@"result"][@"notification"]];
            NSInteger pages = [(NSNumber *)responseData[@"result"][@"pages"] integerValue];
            successBlock(list, pages);
        }
    } errorBlock:failBlock];
}
+ (void)taolikePostWithPostId:(NSString *)post_id comment_id:(NSString *)comment_id like:(BOOL)like successBlock:(dispatch_block_t)successBlock failBlock:(BJServiceErrorBlock)failBlock {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"post_id"] = post_id;
    params[@"comment_id"] = comment_id;
    params[@"like"] = @(like);
    [GlodBuleBJHTTPServiceEngine tao_postRequestWithFunctionPath:API_USER_LIKE_ADD params:params successBlock:^(id responseData) {
        if (successBlock) {
            successBlock();
        }
    } errorBlock:failBlock];
}
+ (void)taopostCommentWithComment_txt:(NSString *)comment_txt post_id:(NSString *)post_id reply_comment_id:(NSString *)reply_comment_id successBlock:(dispatch_block_t)successBlock failBlock:(BJServiceErrorBlock)failBlock {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"post_id"] = post_id;
    params[@"comment_txt"] = comment_txt;
    params[@"reply_comment_id"] = reply_comment_id;
    [GlodBuleBJHTTPServiceEngine tao_postRequestWithFunctionPath:API_USER_POST_COMMENT params:params successBlock:^(id responseData) {
        if (successBlock) {
            successBlock();
        }
    } errorBlock:failBlock];
}


+ (void)taoaddLikeWithNewsId:(NSString *)news_id successBlock:(dispatch_block_t)successBlock failBlock:(BJServiceErrorBlock)failBlock { // 0-取消点赞 1-点赞
    [GlodBuleBJHTTPServiceEngine tao_getRequestWithFunctionPath:API_USER_POST_LIKE params:@{@"post_id": news_id, @"like":@"1"} successBlock:^(id responseData) {
        if (successBlock) {
            successBlock();
        }
    } errorBlock:failBlock];
}
+ (void)taodeleteLikeWithNewsId:(NSString *)news_id successBlock:(dispatch_block_t)successBlock failBlock:(BJServiceErrorBlock)failBlock {
    [GlodBuleBJHTTPServiceEngine tao_getRequestWithFunctionPath:API_USER_POST_LIKE params:@{@"post_id": news_id,@"like":@"0"} successBlock:^(id responseData) {
        if (successBlock) {
            successBlock();
        }
    } errorBlock:failBlock];
}

@end
