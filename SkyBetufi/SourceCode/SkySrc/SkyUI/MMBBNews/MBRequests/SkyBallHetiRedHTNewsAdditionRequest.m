#import "SkyBallHetiRedHTNewsAdditionRequest.h"
@implementation SkyBallHetiRedHTNewsAdditionRequest
+ (void)waterSkyrequestNormalCommentWithOffset:(NSInteger)offset newsId:(NSString *)newsId successBlock:(void(^)(NSArray <SkyBallHetiRedHTCommentModel *> *commentList, NSInteger pages))successBlock failBlock:(BJServiceErrorBlock)failBlock {
    [SkyBallHetiRedBJHTTPServiceEngine waterSky_postRequestWithFunctionPath:API_NEWS_COMMENTS params:@{@"offset": @(offset), @"post_id": newsId} successBlock:^(id responseData) {
        if (successBlock) {
            NSArray *commentsData = responseData[@"result"][@"comments"];
            NSArray<SkyBallHetiRedHTCommentModel *> *comments = [NSArray yy_modelArrayWithClass:[SkyBallHetiRedHTCommentModel class] json:commentsData];
            NSInteger pages = [(NSNumber *)responseData[@"result"][@"pages"] integerValue];
            successBlock(comments, pages);
        }
    } errorBlock:failBlock];
}
+ (void)waterSkyrequestHotCommentWithOffset:(NSInteger)offset newsId:(NSString *)newsId successBlock:(void(^)(NSArray <SkyBallHetiRedHTCommentModel *> *commentList, NSInteger pages))successBlock failBlock:(BJServiceErrorBlock)failBlock {
    [SkyBallHetiRedBJHTTPServiceEngine waterSky_postRequestWithFunctionPath:API_NEWS_HOT_COMMENT params:@{@"offset": @(offset), @"post_id": newsId} successBlock:^(id responseData) {
        if (successBlock) {
            NSArray *commentsData = responseData[@"result"][@"comments"];
            NSArray<SkyBallHetiRedHTCommentModel *> *comments = [NSArray yy_modelArrayWithClass:[SkyBallHetiRedHTCommentModel class] json:commentsData];
            NSInteger pages = [(NSNumber *)responseData[@"result"][@"pages"] integerValue];
            successBlock(comments, pages);
        }
    } errorBlock:failBlock];
}
+ (void)waterSkyrequestAllCommentWithPostId:(NSString *)postId
                       successBlock:(void(^)(NSArray <SkyBallHetiRedHTCommentModel *> *commentList, NSArray<SkyBallHetiRedHTCommentModel *> *hotComments))successBlock
                          failBlock:(BJServiceErrorBlock)failBlock {
    [SkyBallHetiRedBJHTTPServiceEngine waterSky_postRequestWithFunctionPath:API_NEWS_ALL_COMMENT params:@{@"post_id": postId} successBlock:^(id responseData) {
        if (successBlock) {
            NSArray *comments = [NSArray yy_modelArrayWithClass:[SkyBallHetiRedHTCommentModel class] json:responseData[@"get_comments"][@"result"][@"comments"]];
            NSArray *hotComments = [NSArray yy_modelArrayWithClass:[SkyBallHetiRedHTCommentModel class] json:responseData[@"get_hot_comments"][@"result"][@"comments"]];
            successBlock(comments, hotComments);
        }
    } errorBlock:failBlock];
}
+ (void)waterSkyrequestDetailWithPostId:(NSString *)post_id
                   successBlock:(void(^)(SkyBallHetiRedHTNewsModel *newsModel))successBlock
                     errorBlock:(BJServiceErrorBlock)errorBlock {
    [SkyBallHetiRedBJHTTPServiceEngine waterSky_postRequestWithFunctionPath:API_NEWS_DETAIL params:@{@"post_id": post_id} successBlock:^(id responseData) {
        if (successBlock) {
            successBlock([SkyBallHetiRedHTNewsModel yy_modelWithJSON:responseData[@"post"]]);
        }
    } errorBlock:errorBlock];
}
@end
