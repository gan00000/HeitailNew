//
//  HTNewsDetailViewController.m
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/9/10.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import "YYPackageHTMatchVideoLiveViewController.h"
#import "KMonkeyHTNewsTopRequest.h"
#import "RRDogHTNewsHeaderCell.h"
#import "NDeskHTNewsWebCell.h"
#import "YYPackageHTNewsHomeCell.h"
#import "NDeskHTNewsTopHeaderView.h"
#import "HoursePPXXBJNavigationController.h"
#import "GGCatHTNewsAdditionRequest.h"
#import "HourseHTUserRequest.h"
#import <YYText/YYText.h>
#import "HourseHTCommentGetter.h"
#import "NDeskHTNewsCommentCell.h"
#import "RRDogHTNoCommentFooterView.h"
#import "HourseHTNewsDetailViewController.h"
#import "PXFunBJHTTPServiceEngine.h"

@interface YYPackageHTMatchVideoLiveViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
//@property (weak, nonatomic) IBOutlet UIButton *commentButton;
//@property (weak, nonatomic) IBOutlet UIButton *saveButton;
//@property (weak, nonatomic) IBOutlet UIButton *sendButton;
//@property (weak, nonatomic) IBOutlet JXTextView *commentInputView;
//@property (weak, nonatomic) IBOutlet UILabel *commentCountLabel;
//@property (weak, nonatomic) IBOutlet JXView *commentCountContent;
//@property (weak, nonatomic) IBOutlet UIView *buttonContentView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *comtentHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentRight;

@property (nonatomic, strong) PXFunHTNewsModel *newsModel;
@property (nonatomic, strong) NSArray *topNewsList;
@property (nonatomic, copy) NSString *htmlContent;
@property (nonatomic, assign) CGFloat newsContentHeight;
//@property (nonatomic, assign) BOOL topRequestDone;
@property (nonatomic, assign) BOOL htmlLoadDone;
@property (nonatomic, weak) HourseHTCommentModel *currentCommentModel;
@property (nonatomic, strong) HourseHTCommentGetter *commentGetter;
@property (nonatomic, strong) RRDogHTNoCommentFooterView *noCommentsFooterView;

@property (nonatomic, assign) BOOL isFirstShow;

@end

@implementation YYPackageHTMatchVideoLiveViewController

+ (instancetype)taoviewController {
    return kLoadStoryboardWithName(@"SkyBallHetiRedHTMatchVideoLive");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self taosetupViews];
    
    self.isFirstShow = YES;//防止viewDidAppear的时候多次调用
}

- (void)taoRequestInitAllData {
    [self taoRequestPostidByGameid:^{
        
        [self taoLoadDetailWithCompleteBlock:^{
            [self taorequestLiveDataRequests];
        }];
        
    }];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (self.isFirstShow) {
        self.isFirstShow = NO;
        
        [self taoRequestInitAllData];
       
//        [self addHistoryRecord];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if ( !self.htmlLoadDone) {
        return 0;
    }
//    NSInteger num = 3;
//    if (self.commentGetter.hotComments.count > 0) {
//        num ++;
//    }
//    if (self.commentGetter.normalComments.count > 0) {
//        num ++;
//    }
//    return num;
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
     return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    kWeakSelf
    NDeskHTNewsWebCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NDeskHTNewsWebCell"];
    if (self.newsContentHeight == 0) {
        [cell taosetupWithClearHtmlContent:self.htmlContent];
        cell.onContentHeightUpdateBlock = ^(CGFloat height) {
            if (fabs(height - weakSelf.newsContentHeight) < 1) {
                return;
            }
            weakSelf.newsContentHeight = height;
            [weakSelf.tableView reloadData];
        };
    }
    
    
    return cell;

}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
     return self.newsContentHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0 || section == 1) {
        return 0.1;
    }
    return 40;
}

- (UITableViewHeaderFooterView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
     return nil;
}

#pragma mark - requests
- (void)taoLoadDetailWithCompleteBlock:(dispatch_block_t)block {
    [GGCatHTNewsAdditionRequest taorequestDetailWithPostId:self.post_id successBlock:^(PXFunHTNewsModel * _Nonnull newsModel) {
        self.newsModel = newsModel;
        if (block) {
            block();
        }
    } errorBlock:^(SundayBJError *error) {
        [self.view showToast:@"數據拉取失敗"];
        if (!self.newsModel) {
            [self.view showEmptyViewWithTitle:@"數據拉取失敗，點擊重試" tapBlock:^{
                [self.view hideEmptyView];
                [self.view showLoadingView];
                [self taoLoadDetailWithCompleteBlock:block];
            }];
        }
    }];
}

-(void)taoRequestPostidByGameid:(dispatch_block_t)block{
    
    [PXFunBJHTTPServiceEngine tao_getRequestWithFunctionPath:API_MATCH_LIVE_POST_GAME params:@{@"game_id":self.game_id}
      successBlock:^(id responseData) {
          
          if (responseData) {
              NSDictionary *mPostIdDic = responseData;
              NSArray *aArry = mPostIdDic[@"result"];
              if (aArry) {
                  NSDictionary *firstPostDic = aArry[0];
                  if (firstPostDic && firstPostDic[@"post_id"]) {
                      self.post_id = firstPostDic[@"post_id"];
                      NSLog(@"requestPostidByGameid");
                      if (block) {
                          block();
                      }
                       return;
                  }
              }
          }
         
          [self.view showToast:@"數據拉取失敗"];
          if (!self.post_id) {
              [self.view showEmptyViewWithTitle:@"數據拉取失敗，點擊重試" tapBlock:^{
                  [self.view hideEmptyView];
                  [self.view showLoadingView];
                  [self taoRequestPostidByGameid:block];
              }];
          }
         
          
      } errorBlock:^(SundayBJError *error) {
          
          [self.view showToast:@"數據拉取失敗"];
          if (!self.post_id) {
              [self.view showEmptyViewWithTitle:@"數據拉取失敗，點擊重試" tapBlock:^{
                  [self.view hideEmptyView];
                  [self.view showLoadingView];
                  [self taoRequestPostidByGameid:block];
              }];
          }
      }];
    
}

// 请求html数据、推荐数据、第一页评论
- (void)taorequestLiveDataRequests {
    kWeakSelf
//    self.htmlLoadDone = YES;
    
    self.htmlLoadDone = NO;
    [self.newsModel taogetClearContentWithBlock:^(BOOL success, NSString *content) {
        weakSelf.htmlContent = content;
        weakSelf.htmlLoadDone = YES;
        NSLog(@"刷新数据成功");
        [weakSelf taorefreshUI];
    }];
}


#pragma mark - UI refresh
- (void)taosetupViews {
    [self.view showLoadingView];
    
//    self.title = @"新聞詳情";
    self.newsContentHeight = 0;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    
//    [self.tableView registerNib:[UINib nibWithNibName:@"HTNewsHeaderCell" bundle:nil]
//         forCellReuseIdentifier:@"HTNewsHeaderCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"NDeskHTNewsWebCell" bundle:nil]
         forCellReuseIdentifier:@"NDeskHTNewsWebCell"];
//    [self.tableView registerNib:[UINib nibWithNibName:@"HTNewsHomeCell" bundle:nil]
//         forCellReuseIdentifier:@"HTNewsHomeCell"];
//    [self.tableView registerNib:[UINib nibWithNibName:@"HTNewsTopHeaderView" bundle:nil] forHeaderFooterViewReuseIdentifier:@"HTNewsTopHeaderView"];
//    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HTNewsCommentCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([HTNewsCommentCell class])];
    
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
//    kWeakSelf
//    self.tableView.mj_footer = [MJRefreshGenerator bj_foorterWithRefreshingBlock:^{
//        [weakSelf loadComments];
//    }];
    
//    if ([HTNewsModel skargcanShare]) {
//        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"nav_icon_share"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] style:UIBarButtonItemStylePlain target:self action:@selector(onShareButtonTapped:)];
//    }
    kWeakSelf
    self.tableView.mj_header = [HourseMJRefreshGenerator bj_headerWithRefreshingBlock:^{
        NSLog(@"bj_headerWithRefreshingBlock");
         [self taoRequestInitAllData];
    }];

}

- (void)taorefreshUI {
    
    [self.tableView.mj_header endRefreshing];
    
    if (!self.htmlLoadDone) {
        return;
    }
    
    [self.view hideLoadingView];
    [self.tableView reloadData];
    
//    [self setupSaveButton];

}



#pragma mark - actions
- (void)onShareButtonTapped:(id)sender {
    [self.newsModel taoshare];
}



#pragma mark - lazy load
- (HourseHTCommentGetter *)commentGetter {
    if (!_commentGetter) {
        _commentGetter = [[HourseHTCommentGetter alloc] initWithPostId:self.post_id];
    }
    return _commentGetter;
}

- (RRDogHTNoCommentFooterView *)noCommentsFooterView {
    if (!_noCommentsFooterView) {
        _noCommentsFooterView = [RRDogHTNoCommentFooterView taofooterViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
    }
    return _noCommentsFooterView;
}

@end
