#import "GGCatHTNewsAdditionRequest.h"
@implementation GGCatHTNewsAdditionRequest
+ (void)taorequestNormalCommentWithOffset:(NSInteger)offset newsId:(NSString *)newsId successBlock:(void(^)(NSArray <HourseHTCommentModel *> *commentList, NSInteger pages))successBlock failBlock:(BJServiceErrorBlock)failBlock {
    [PXFunBJHTTPServiceEngine tao_postRequestWithFunctionPath:API_NEWS_COMMENTS params:@{@"offset": @(offset), @"post_id": newsId} successBlock:^(id responseData) {
        if (successBlock) {
            NSArray *commentsData = responseData[@"result"][@"comments"];
            NSArray<HourseHTCommentModel *> *comments = [NSArray yy_modelArrayWithClass:[HourseHTCommentModel class] json:commentsData];
            NSInteger pages = [(NSNumber *)responseData[@"result"][@"pages"] integerValue];
            successBlock(comments, pages);
        }
    } errorBlock:failBlock];
}
+ (void)taorequestHotCommentWithOffset:(NSInteger)offset newsId:(NSString *)newsId successBlock:(void(^)(NSArray <HourseHTCommentModel *> *commentList, NSInteger pages))successBlock failBlock:(BJServiceErrorBlock)failBlock {
    [PXFunBJHTTPServiceEngine tao_postRequestWithFunctionPath:API_NEWS_HOT_COMMENT params:@{@"offset": @(offset), @"post_id": newsId} successBlock:^(id responseData) {
        if (successBlock) {
            NSArray *commentsData = responseData[@"result"][@"comments"];
            NSArray<HourseHTCommentModel *> *comments = [NSArray yy_modelArrayWithClass:[HourseHTCommentModel class] json:commentsData];
            NSInteger pages = [(NSNumber *)responseData[@"result"][@"pages"] integerValue];
            successBlock(comments, pages);
        }
    } errorBlock:failBlock];
}
+ (void)taorequestAllCommentWithPostId:(NSString *)postId
                       successBlock:(void(^)(NSArray <HourseHTCommentModel *> *commentList, NSArray<HourseHTCommentModel *> *hotComments))successBlock
                          failBlock:(BJServiceErrorBlock)failBlock {
    [PXFunBJHTTPServiceEngine tao_postRequestWithFunctionPath:API_NEWS_ALL_COMMENT params:@{@"post_id": postId} successBlock:^(id responseData) {
        if (successBlock) {
            NSArray *comments = [NSArray yy_modelArrayWithClass:[HourseHTCommentModel class] json:responseData[@"get_comments"][@"result"][@"comments"]];
            NSArray *hotComments = [NSArray yy_modelArrayWithClass:[HourseHTCommentModel class] json:responseData[@"get_hot_comments"][@"result"][@"comments"]];
            successBlock(comments, hotComments);
        }
    } errorBlock:failBlock];
}
+ (void)taorequestDetailWithPostId:(NSString *)post_id
                   successBlock:(void(^)(PXFunHTNewsModel *newsModel))successBlock
                     errorBlock:(BJServiceErrorBlock)errorBlock {
    [PXFunBJHTTPServiceEngine tao_postRequestWithFunctionPath:API_NEWS_DETAIL params:@{@"post_id": post_id} successBlock:^(id responseData) {
        if (successBlock) {
            
            NSArray *xxHTNewsDetailModels = [NSArray yy_modelArrayWithClass:[YYPackageHTNewsDetailModel class] json:responseData[@"post"][@"new_content"]];
            NSMutableArray *maData = [NSMutableArray array];
            
            for (YYPackageHTNewsDetailModel * d in xxHTNewsDetailModels) {
                if ([d.type isEqualToString:@"text"] && [d.data hasPrefix:@"<a"] && [d.data hasSuffix:@"></a>"]) {
                    
                }else{
                    [maData addObject:d];
                }
            }
            
            PXFunHTNewsModel *mHTNewsModel = [PXFunHTNewsModel yy_modelWithJSON:responseData[@"post"]];

            mHTNewsModel.mHTNewsDetailModels = maData;
            successBlock(mHTNewsModel);
        }
    } errorBlock:errorBlock];
}
@end
