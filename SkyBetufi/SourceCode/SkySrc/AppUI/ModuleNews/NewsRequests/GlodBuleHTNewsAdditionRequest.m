#import "GlodBuleHTNewsAdditionRequest.h"
@implementation GlodBuleHTNewsAdditionRequest
+ (void)taorequestNormalCommentWithOffset:(NSInteger)offset newsId:(NSString *)newsId successBlock:(void(^)(NSArray <GlodBuleHTCommentModel *> *commentList, NSInteger pages))successBlock failBlock:(BJServiceErrorBlock)failBlock {
    [GlodBuleBJHTTPServiceEngine tao_postRequestWithFunctionPath:API_NEWS_COMMENTS params:@{@"offset": @(offset), @"post_id": newsId} successBlock:^(id responseData) {
        if (successBlock) {
            NSArray *commentsData = responseData[@"result"][@"comments"];
            NSArray<GlodBuleHTCommentModel *> *comments = [NSArray yy_modelArrayWithClass:[GlodBuleHTCommentModel class] json:commentsData];
            NSInteger pages = [(NSNumber *)responseData[@"result"][@"pages"] integerValue];
            successBlock(comments, pages);
        }
    } errorBlock:failBlock];
}
+ (void)taorequestHotCommentWithOffset:(NSInteger)offset newsId:(NSString *)newsId successBlock:(void(^)(NSArray <GlodBuleHTCommentModel *> *commentList, NSInteger pages))successBlock failBlock:(BJServiceErrorBlock)failBlock {
    [GlodBuleBJHTTPServiceEngine tao_postRequestWithFunctionPath:API_NEWS_HOT_COMMENT params:@{@"offset": @(offset), @"post_id": newsId} successBlock:^(id responseData) {
        if (successBlock) {
            NSArray *commentsData = responseData[@"result"][@"comments"];
            NSArray<GlodBuleHTCommentModel *> *comments = [NSArray yy_modelArrayWithClass:[GlodBuleHTCommentModel class] json:commentsData];
            NSInteger pages = [(NSNumber *)responseData[@"result"][@"pages"] integerValue];
            successBlock(comments, pages);
        }
    } errorBlock:failBlock];
}
+ (void)taorequestAllCommentWithPostId:(NSString *)postId
                       successBlock:(void(^)(NSArray <GlodBuleHTCommentModel *> *commentList, NSArray<GlodBuleHTCommentModel *> *hotComments))successBlock
                          failBlock:(BJServiceErrorBlock)failBlock {
    [GlodBuleBJHTTPServiceEngine tao_postRequestWithFunctionPath:API_NEWS_ALL_COMMENT params:@{@"post_id": postId} successBlock:^(id responseData) {
        if (successBlock) {
            NSArray *comments = [NSArray yy_modelArrayWithClass:[GlodBuleHTCommentModel class] json:responseData[@"get_comments"][@"result"][@"comments"]];
            NSArray *hotComments = [NSArray yy_modelArrayWithClass:[GlodBuleHTCommentModel class] json:responseData[@"get_hot_comments"][@"result"][@"comments"]];
            successBlock(comments, hotComments);
        }
    } errorBlock:failBlock];
}
+ (void)taorequestDetailWithPostId:(NSString *)post_id
                   successBlock:(void(^)(GlodBuleHTNewsModel *newsModel))successBlock
                     errorBlock:(BJServiceErrorBlock)errorBlock {
    [GlodBuleBJHTTPServiceEngine tao_postRequestWithFunctionPath:API_NEWS_DETAIL params:@{@"post_id": post_id} successBlock:^(id responseData) {
        if (successBlock) {
            
            NSArray *xxHTNewsDetailModels = [NSArray yy_modelArrayWithClass:[HTNewsDetailModel class] json:responseData[@"post"][@"new_content"]];
            NSMutableArray *maData = [NSMutableArray array];
            
            for (HTNewsDetailModel * d in xxHTNewsDetailModels) {
                if ([d.type isEqualToString:@"text"] && [d.data hasPrefix:@"<a"] && [d.data hasSuffix:@"></a>"]) {
                    
                }else{
                    [maData addObject:d];
                }
            }
            
            GlodBuleHTNewsModel *mGlodBuleHTNewsModel = [GlodBuleHTNewsModel yy_modelWithJSON:responseData[@"post"]];

            mGlodBuleHTNewsModel.mHTNewsDetailModels = maData;
            successBlock(mGlodBuleHTNewsModel);
        }
    } errorBlock:errorBlock];
}
@end
