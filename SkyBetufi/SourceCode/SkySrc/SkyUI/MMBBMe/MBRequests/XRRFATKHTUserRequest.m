//
//  HTLoginRequest.m
//  HeiteBasketball
//
//  Created by 冯生伟 on 2019/4/6.
//  Copyright © 2019 Dean_F. All rights reserved.
//

#import "XRRFATKHTUserRequest.h"

@implementation XRRFATKHTUserRequest

+ (void)skargdoLoginRequestWithAccessToken:(NSString *)accessToken
                                  sns:(NSInteger)sns
                         successBlock:(void(^)(NSString *userToken))successBlock
                            failBlock:(BJServiceErrorBlock)failBlock {
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"sns_login"] = @(sns);
    param[@"access_token"] = accessToken;
    param[@"device_token"] = [XRRFATKHTUserManager skarg_deviceToken];
    param[@"device_type"] = @(1);
    
    [XRRFATKBJHTTPServiceEngine postRequestWithFunctionPath:API_USER_LOGIN params:param successBlock:^(id responseData) {
        if (successBlock) {
            successBlock(responseData[@"result"][@"user_token"]);
        }
    } errorBlock:failBlock];
}

+ (void)skargrequestUserInfoWithSuccessBlock:(void(^)(NSDictionary *userInfo))successBlock
                              failBlock:(BJServiceErrorBlock)failBlock {
    [XRRFATKBJHTTPServiceEngine getRequestWithFunctionPath:API_USER_INFO params:nil successBlock:^(id responseData) {
        if (successBlock) {
            successBlock(responseData[@"result"]);
        }
    } errorBlock:failBlock];
}

+ (void)skargupdateUserInfoWithEmail:(NSString *)email
                    displayName:(NSString *)displayName
                           file:(NSString *)file
                   successBlock:(void(^)(NSDictionary *userInfo))successBlock
                      failBlock:(BJServiceErrorBlock)failBlock {
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"email"] = email;
    param[@"display_name"] = displayName;
    param[@"file"] = file;
    
    [XRRFATKBJHTTPServiceEngine postRequestWithFunctionPath:API_USER_UPDATE params:param successBlock:^(id responseData) {
        if (successBlock) {
            successBlock(responseData[@"result"]);
        }
    } errorBlock:failBlock];
}

+ (void)skargrequestCollectionListWithOffset:(NSInteger)offset successBlock:(void(^)(NSArray <XRRFATKHTNewsModel *> *newsList, NSInteger pages))successBlock failBlock:(BJServiceErrorBlock)failBlock {
    [XRRFATKBJHTTPServiceEngine postRequestWithFunctionPath:API_USER_SAVE_LIST params:@{@"offset": @(offset)} successBlock:^(id responseData) {
        if (successBlock) {
            successBlock([NSArray yy_modelArrayWithClass:[XRRFATKHTNewsModel class] json:responseData[@"savedposts"][@"posts"]], [(NSNumber *)responseData[@"savedposts"][@"pages"] integerValue]);
        }
    } errorBlock:failBlock];
}

+ (void)skargaddCollectionWithNewsId:(NSString *)news_id successBlock:(dispatch_block_t)successBlock failBlock:(BJServiceErrorBlock)failBlock {
    [XRRFATKBJHTTPServiceEngine postRequestWithFunctionPath:API_USER_SAVE_ADD params:@{@"post_id": news_id} successBlock:^(id responseData) {
        if (successBlock) {
            successBlock();
        }
    } errorBlock:failBlock];
}

+ (void)skargdeleteCollectionWithNewsId:(NSString *)news_id successBlock:(dispatch_block_t)successBlock failBlock:(BJServiceErrorBlock)failBlock {
    [XRRFATKBJHTTPServiceEngine postRequestWithFunctionPath:API_USER_UNSAVE params:@{@"post_id": news_id} successBlock:^(id responseData) {
        if (successBlock) {
            successBlock();
        }
    } errorBlock:failBlock];
}

+ (void)skargrequestHistoryWithOffset:(NSInteger)offset
                    successBlock:(HTMyCommentBlock)successBlock
                       failBlock:(BJServiceErrorBlock)failBlock {
    [XRRFATKBJHTTPServiceEngine postRequestWithFunctionPath:API_USER_HISTORY_LIST params:@{@"offset": @(offset)} successBlock:^(id responseData) {
        if (successBlock) {
            NSArray *list = [NSArray yy_modelArrayWithClass:[XRRFATKHTNewsModel class] json:responseData[@"historyposts"][@"posts"]];
            NSInteger pages = [(NSNumber *)responseData[@"historyposts"][@"pages"] integerValue];
            successBlock(list, pages);
        }
    } errorBlock:failBlock];
}

+ (void)skargaddHistoryWithNewsId:(NSString *)news_id successBlock:(dispatch_block_t)successBlock failBlock:(BJServiceErrorBlock)failBlock {
    [XRRFATKBJHTTPServiceEngine postRequestWithFunctionPath:API_USER_HISTORY_ADD params:@{@"post_id": news_id} successBlock:^(id responseData) {
        if (successBlock) {
            successBlock();
        }
    } errorBlock:failBlock];
}

+ (void)skargrequestMyCommentWithOffset:(NSInteger)offset successBlock:(void(^)(NSArray <XRRFATKHTNewsModel *> *newsList, NSInteger pages))successBlock failBlock:(BJServiceErrorBlock)failBlock {
    [XRRFATKBJHTTPServiceEngine postRequestWithFunctionPath:API_USER_MY_COMMENT params:@{@"offset": @(offset)} successBlock:^(id responseData) {
        if (successBlock) {
            NSArray *newsList = [NSArray yy_modelArrayWithClass:[XRRFATKHTNewsModel class] json:responseData[@"savedposts"][@"comments"]];
            NSInteger pages = [(NSNumber *)responseData[@"savedposts"][@"pages"] integerValue];
            successBlock(newsList, pages);
        }
    } errorBlock:failBlock];
}

+ (void)skargrequestMyLikeWithOffset:(NSInteger)offset successBlock:(void(^)(NSArray <XRRFATKHTNewsModel *> *newsList, NSInteger pages))successBlock failBlock:(BJServiceErrorBlock)failBlock {
    [XRRFATKBJHTTPServiceEngine postRequestWithFunctionPath:API_USER_MY_LIKE params:@{@"offset": @(offset)} successBlock:^(id responseData) {
        if (successBlock) {
            NSArray *newsList = [NSArray yy_modelArrayWithClass:[XRRFATKHTNewsModel class] json:responseData[@"savedposts"][@"comments"]];
            NSInteger pages = [(NSNumber *)responseData[@"savedposts"][@"pages"] integerValue];
            successBlock(newsList, pages);
        }
    } errorBlock:failBlock];
}

+ (void)skargrequestUnReadMessageCountWithSuccessBlock:(void(^)(NSInteger count))successBlock failBlock:(BJServiceErrorBlock)failBlock {
    [XRRFATKBJHTTPServiceEngine postRequestWithFunctionPath:API_USER_MESSAGE_COUNT params:nil successBlock:^(id responseData) {
        if (successBlock) {
            successBlock([(NSString *)responseData[@"result"][@"total_unread"] integerValue]);
        }
    } errorBlock:failBlock];
}

+ (void)skargrequestMyMessageWithOffset:(NSInteger)offset
                      successBlock:(void(^)(NSArray <XRRFATKHTMyMessageModel *> *messageList, NSInteger pages))successBlock
                         failBlock:(BJServiceErrorBlock)failBlock {
    [XRRFATKBJHTTPServiceEngine postRequestWithFunctionPath:API_USER_MESSAGE_LIST params:@{@"offset": @(offset)} successBlock:^(id responseData) {
        if (successBlock) {
            NSArray *list = [NSArray yy_modelArrayWithClass:[XRRFATKHTMyMessageModel class] json:responseData[@"result"][@"notification"]];
            NSInteger pages = [(NSNumber *)responseData[@"result"][@"pages"] integerValue];
            successBlock(list, pages);
        }
    } errorBlock:failBlock];
}

+ (void)skarglikePostWithPostId:(NSString *)post_id comment_id:(NSString *)comment_id like:(BOOL)like successBlock:(dispatch_block_t)successBlock failBlock:(BJServiceErrorBlock)failBlock {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"post_id"] = post_id;
    params[@"comment_id"] = comment_id;
    params[@"like"] = @(like);
    
    [XRRFATKBJHTTPServiceEngine postRequestWithFunctionPath:API_USER_LIKE_ADD params:params successBlock:^(id responseData) {
        if (successBlock) {
            successBlock();
        }
    } errorBlock:failBlock];
}

+ (void)skargpostCommentWithComment_txt:(NSString *)comment_txt post_id:(NSString *)post_id reply_comment_id:(NSString *)reply_comment_id successBlock:(dispatch_block_t)successBlock failBlock:(BJServiceErrorBlock)failBlock {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"post_id"] = post_id;
    params[@"comment_txt"] = comment_txt;
    params[@"reply_comment_id"] = reply_comment_id;
    
    [XRRFATKBJHTTPServiceEngine postRequestWithFunctionPath:API_USER_POST_COMMENT params:params successBlock:^(id responseData) {
        if (successBlock) {
            successBlock();
        }
    } errorBlock:failBlock];
}

@end
