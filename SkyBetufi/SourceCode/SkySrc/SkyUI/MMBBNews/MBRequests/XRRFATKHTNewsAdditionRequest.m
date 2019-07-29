//
//  XRRFATKHTNewsAdditionRequest.m
//  HeiteBasketball
//
//  Created by 冯生伟 on 2019/4/8.
//  Copyright © 2019 Dean_F. All rights reserved.
//

#import "XRRFATKHTNewsAdditionRequest.h"

@implementation XRRFATKHTNewsAdditionRequest

+ (void)skargrequestNormalCommentWithOffset:(NSInteger)offset newsId:(NSString *)newsId successBlock:(void(^)(NSArray <XRRFATKHTCommentModel *> *commentList, NSInteger pages))successBlock failBlock:(BJServiceErrorBlock)failBlock {
    [XRRFATKBJHTTPServiceEngine postRequestWithFunctionPath:API_NEWS_COMMENTS params:@{@"offset": @(offset), @"post_id": newsId} successBlock:^(id responseData) {
        if (successBlock) {
            NSArray *commentsData = responseData[@"result"][@"comments"];
            NSArray<XRRFATKHTCommentModel *> *comments = [NSArray yy_modelArrayWithClass:[XRRFATKHTCommentModel class] json:commentsData];
            NSInteger pages = [(NSNumber *)responseData[@"result"][@"pages"] integerValue];
            successBlock(comments, pages);
        }
    } errorBlock:failBlock];
}

+ (void)skargrequestHotCommentWithOffset:(NSInteger)offset newsId:(NSString *)newsId successBlock:(void(^)(NSArray <XRRFATKHTCommentModel *> *commentList, NSInteger pages))successBlock failBlock:(BJServiceErrorBlock)failBlock {
    [XRRFATKBJHTTPServiceEngine postRequestWithFunctionPath:API_NEWS_HOT_COMMENT params:@{@"offset": @(offset), @"post_id": newsId} successBlock:^(id responseData) {
        if (successBlock) {
            NSArray *commentsData = responseData[@"result"][@"comments"];
            NSArray<XRRFATKHTCommentModel *> *comments = [NSArray yy_modelArrayWithClass:[XRRFATKHTCommentModel class] json:commentsData];
            NSInteger pages = [(NSNumber *)responseData[@"result"][@"pages"] integerValue];
            successBlock(comments, pages);
        }
    } errorBlock:failBlock];
}

+ (void)skargrequestAllCommentWithPostId:(NSString *)postId
                       successBlock:(void(^)(NSArray <XRRFATKHTCommentModel *> *commentList, NSArray<XRRFATKHTCommentModel *> *hotComments))successBlock
                          failBlock:(BJServiceErrorBlock)failBlock {
    [XRRFATKBJHTTPServiceEngine postRequestWithFunctionPath:API_NEWS_ALL_COMMENT params:@{@"post_id": postId} successBlock:^(id responseData) {
        if (successBlock) {
            NSArray *comments = [NSArray yy_modelArrayWithClass:[XRRFATKHTCommentModel class] json:responseData[@"get_comments"][@"result"][@"comments"]];
            NSArray *hotComments = [NSArray yy_modelArrayWithClass:[XRRFATKHTCommentModel class] json:responseData[@"get_hot_comments"][@"result"][@"comments"]];
            successBlock(comments, hotComments);
        }
    } errorBlock:failBlock];
}

// 新闻详情
+ (void)skargrequestDetailWithPostId:(NSString *)post_id
                   successBlock:(void(^)(XRRFATKHTNewsModel *newsModel))successBlock
                     errorBlock:(BJServiceErrorBlock)errorBlock {
    [XRRFATKBJHTTPServiceEngine postRequestWithFunctionPath:API_NEWS_DETAIL params:@{@"post_id": post_id} successBlock:^(id responseData) {
        if (successBlock) {
            successBlock([XRRFATKHTNewsModel yy_modelWithJSON:responseData[@"post"]]);
        }
    } errorBlock:errorBlock];
}


@end
