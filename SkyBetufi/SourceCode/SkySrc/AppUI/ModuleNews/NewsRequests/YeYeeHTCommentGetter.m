#import "YeYeeHTCommentGetter.h"
#import "YeYeeHTNewsAdditionRequest.h"
@interface YeYeeHTCommentGetter ()
@property (nonatomic, assign) NSInteger hotOffset;
@property (nonatomic, assign) NSInteger normalOffset;
@property (nonatomic, assign) BOOL hasMoreHot;
@property (nonatomic, assign) BOOL hasMoreNormal;
@property (nonatomic, copy) NSString *post_id;
@property (nonatomic, strong) NSArray *incompletePage; 
@end
@implementation YeYeeHTCommentGetter
- (instancetype)initWithPostId:(NSString *)post_id {
    self = [super init];
    if (self) {
        self.post_id = post_id;
        self.hotComments = [NSMutableArray array];
        self.normalComments = [NSMutableArray array];
        [self taoreset];
    }
    return self;
}
- (void)taoreset {
    self.hotOffset = 0;
    self.normalOffset = 0;
    self.hasMoreHot = YES;
    self.hasMoreNormal = YES;
    self.hasMore = YES;
}
- (void)taodoRequestWithCompleteBlock:(dispatch_block_t)commentBlock {
    if (self.hasMoreHot) {
        [self loadHotCommentsWithCompleteBlock:commentBlock];
    } else {
        [self loadNormalCommentsWithCompleteBlock:commentBlock];
    }
}
- (void)loadHotCommentsWithCompleteBlock:(dispatch_block_t)block {
    [YeYeeHTNewsAdditionRequest taorequestHotCommentWithOffset:self.hotOffset newsId:self.post_id successBlock:^(NSArray<NSNiceHTCommentModel *> * _Nonnull commentList, NSInteger pages) {
        if (self.hotOffset == 0) {
            [self.hotComments removeAllObjects];
        }
        if (commentList) {
            [self countHeightForComments:commentList];
            [self.hotComments addObjectsFromArray:commentList];
        }
        if (self.hotOffset < pages - 1) {
            self.hotOffset ++;
            self.hasMoreHot = YES;
            if (block) {
                block();
            }
        } else {
            self.hasMoreHot = NO;
            [self loadNormalCommentsWithCompleteBlock:block];
        }
    } failBlock:^(YeYeeBJError *error) {
        [[UUaksPPXXBJViewControllerCenter currentViewController].view showToast:@"獲取「熱門評論」失敗"];
        if (block) {
            block();
        }
    }];
}
- (void)loadNormalCommentsWithCompleteBlock:(dispatch_block_t)block {
    [YeYeeHTNewsAdditionRequest taorequestNormalCommentWithOffset:self.normalOffset newsId:self.post_id successBlock:^(NSArray<NSNiceHTCommentModel *> * _Nonnull commentList, NSInteger pages) {
        if (self.normalOffset == 0) {
            [self.normalComments removeAllObjects];
        }
        if (commentList) {
            [self countHeightForComments:commentList];
            [self.normalComments addObjectsFromArray:commentList];
        }
        if (self.normalOffset < pages - 1) {
            self.normalOffset ++;
            self.hasMoreNormal = YES;
        } else {
            self.hasMoreNormal = NO;
            self.hasMore = NO;
            if (self.incompletePage) {
                [self.normalComments removeObjectsInArray:self.incompletePage];
            }
            self.incompletePage = commentList;
            if (commentList.count == 10) {
                self.normalOffset ++;
                self.incompletePage = nil;
            }
        }
        if (block) {
            block();
        }
    } failBlock:^(YeYeeBJError *error) {
        [[UUaksPPXXBJViewControllerCenter currentViewController].view showToast:@"獲取「全部評論」失敗"];
        if (block) {
            block();
        }
    }];
}
- (void)countHeightForComments:(NSArray<NSNiceHTCommentModel *> *)comments {
    for (NSNiceHTCommentModel *commentModel in comments) {
        [commentModel taocountHeight:NO];
    }
}
@end
