#import "GlodBuleHTNewsAdditionRequest.h"
@implementation GlodBuleHTNewsAdditionRequest
+ (void)waterSkyrequestNormalCommentWithOffset:(NSInteger)offset newsId:(NSString *)newsId successBlock:(void(^)(NSArray <GlodBuleHTCommentModel *> *commentList, NSInteger pages))successBlock failBlock:(BJServiceErrorBlock)failBlock {
    [GlodBuleBJHTTPServiceEngine waterSky_postRequestWithFunctionPath:API_NEWS_COMMENTS params:@{@"offset": @(offset), @"post_id": newsId} successBlock:^(id responseData) {
        if (successBlock) {
            NSArray *commentsData = responseData[@"result"][@"comments"];
            NSArray<GlodBuleHTCommentModel *> *comments = [NSArray yy_modelArrayWithClass:[GlodBuleHTCommentModel class] json:commentsData];
            NSInteger pages = [(NSNumber *)responseData[@"result"][@"pages"] integerValue];
            successBlock(comments, pages);
        }
    } errorBlock:failBlock];
}
+ (void)waterSkyrequestHotCommentWithOffset:(NSInteger)offset newsId:(NSString *)newsId successBlock:(void(^)(NSArray <GlodBuleHTCommentModel *> *commentList, NSInteger pages))successBlock failBlock:(BJServiceErrorBlock)failBlock {
    [GlodBuleBJHTTPServiceEngine waterSky_postRequestWithFunctionPath:API_NEWS_HOT_COMMENT params:@{@"offset": @(offset), @"post_id": newsId} successBlock:^(id responseData) {
        if (successBlock) {
            NSArray *commentsData = responseData[@"result"][@"comments"];
            NSArray<GlodBuleHTCommentModel *> *comments = [NSArray yy_modelArrayWithClass:[GlodBuleHTCommentModel class] json:commentsData];
            NSInteger pages = [(NSNumber *)responseData[@"result"][@"pages"] integerValue];
            successBlock(comments, pages);
        }
    } errorBlock:failBlock];
}
+ (void)waterSkyrequestAllCommentWithPostId:(NSString *)postId
                       successBlock:(void(^)(NSArray <GlodBuleHTCommentModel *> *commentList, NSArray<GlodBuleHTCommentModel *> *hotComments))successBlock
                          failBlock:(BJServiceErrorBlock)failBlock {
    [GlodBuleBJHTTPServiceEngine waterSky_postRequestWithFunctionPath:API_NEWS_ALL_COMMENT params:@{@"post_id": postId} successBlock:^(id responseData) {
        if (successBlock) {
            NSArray *comments = [NSArray yy_modelArrayWithClass:[GlodBuleHTCommentModel class] json:responseData[@"get_comments"][@"result"][@"comments"]];
            NSArray *hotComments = [NSArray yy_modelArrayWithClass:[GlodBuleHTCommentModel class] json:responseData[@"get_hot_comments"][@"result"][@"comments"]];
            successBlock(comments, hotComments);
        }
    } errorBlock:failBlock];
}
+ (void)waterSkyrequestDetailWithPostId:(NSString *)post_id
                   successBlock:(void(^)(GlodBuleHTNewsModel *newsModel))successBlock
                     errorBlock:(BJServiceErrorBlock)errorBlock {
    [GlodBuleBJHTTPServiceEngine waterSky_postRequestWithFunctionPath:API_NEWS_DETAIL params:@{@"post_id": post_id} successBlock:^(id responseData) {
        if (successBlock) {
            successBlock([GlodBuleHTNewsModel yy_modelWithJSON:responseData[@"post"]]);
        }
    } errorBlock:errorBlock];
}
@end
