//
//  HTNewsDetailViewController.m
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/9/10.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import "SkyBallHetiRedHTMatchVideoLiveViewController.h"
#import "SkyBallHetiRedHTNewsTopRequest.h"
#import "SkyBallHetiRedHTNewsHeaderCell.h"
#import "SkyBallHetiRedHTNewsWebCell.h"
#import "SkyBallHetiRedHTNewsHomeCell.h"
#import "SkyBallHetiRedHTNewsTopHeaderView.h"
#import "SkyBallHetiRedPPXXBJNavigationController.h"
#import "SkyBallHetiRedHTNewsAdditionRequest.h"
#import "SkyBallHetiRedHTUserRequest.h"
#import <BlocksKit/BlocksKit.h>
#import <YYText/YYText.h>
#import "SkyBallHetiRedHTCommentGetter.h"
#import "SkyBallHetiRedHTNewsCommentCell.h"
#import "SkyBallHetiRedHTNoCommentFooterView.h"
#import "SkyBallHetiRedHTNewsDetailViewController.h"
#import "SkyBallHetiRedBJHTTPServiceEngine.h"

@interface SkyBallHetiRedHTMatchVideoLiveViewController () <UITableViewDelegate, UITableViewDataSource>

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

@property (nonatomic, strong) SkyBallHetiRedHTNewsModel *newsModel;
@property (nonatomic, strong) NSArray *topNewsList;
@property (nonatomic, copy) NSString *htmlContent;
@property (nonatomic, assign) CGFloat newsContentHeight;
//@property (nonatomic, assign) BOOL topRequestDone;
@property (nonatomic, assign) BOOL htmlLoadDone;
@property (nonatomic, weak) SkyBallHetiRedHTCommentModel *currentCommentModel;
@property (nonatomic, strong) SkyBallHetiRedHTCommentGetter *commentGetter;
@property (nonatomic, strong) SkyBallHetiRedHTNoCommentFooterView *noCommentsFooterView;

@property (nonatomic, assign) BOOL isFirstShow;

@end

@implementation SkyBallHetiRedHTMatchVideoLiveViewController

+ (instancetype)waterSkyviewController {
    return kLoadStoryboardWithName(@"SkyBallHetiRedHTMatchVideoLive");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self waterSkysetupViews];
    
    self.isFirstShow = YES;//防止viewDidAppear的时候多次调用
}

- (void)waterSkyRequestInitAllData {
    [self waterSkyRequestPostidByGameid:^{
        
        [self waterSkyLoadDetailWithCompleteBlock:^{
            [self waterSkyrequestLiveDataRequests];
        }];
        
    }];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (self.isFirstShow) {
        self.isFirstShow = NO;
        
        [self waterSkyRequestInitAllData];
       
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
    NSInteger num = 3;
    if (self.commentGetter.hotComments.count > 0) {
        num ++;
    }
    if (self.commentGetter.normalComments.count > 0) {
        num ++;
    }
    return num;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
     return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    kWeakSelf
    SkyBallHetiRedHTNewsWebCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SkyBallHetiRedHTNewsWebCell"];
    if (self.newsContentHeight == 0) {
        [cell waterSkysetupWithClearHtmlContent:self.htmlContent];
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
- (void)waterSkyLoadDetailWithCompleteBlock:(dispatch_block_t)block {
    [SkyBallHetiRedHTNewsAdditionRequest waterSkyrequestDetailWithPostId:self.post_id successBlock:^(SkyBallHetiRedHTNewsModel * _Nonnull newsModel) {
        self.newsModel = newsModel;
        if (block) {
            block();
        }
    } errorBlock:^(SkyBallHetiRedBJError *error) {
        [self.view showToast:@"數據拉取失敗"];
        if (!self.newsModel) {
            [self.view showEmptyViewWithTitle:@"數據拉取失敗，點擊重試" tapBlock:^{
                [self.view hideEmptyView];
                [self.view showLoadingView];
                [self waterSkyLoadDetailWithCompleteBlock:block];
            }];
        }
    }];
}

-(void)waterSkyRequestPostidByGameid:(dispatch_block_t)block{
    
    [SkyBallHetiRedBJHTTPServiceEngine waterSky_getRequestWithFunctionPath:API_MATCH_LIVE_POST_GAME params:@{@"game_id":self.game_id}
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
                  [self waterSkyRequestPostidByGameid:block];
              }];
          }
         
          
      } errorBlock:^(SkyBallHetiRedBJError *error) {
          
          [self.view showToast:@"數據拉取失敗"];
          if (!self.post_id) {
              [self.view showEmptyViewWithTitle:@"數據拉取失敗，點擊重試" tapBlock:^{
                  [self.view hideEmptyView];
                  [self.view showLoadingView];
                  [self waterSkyRequestPostidByGameid:block];
              }];
          }
      }];
    
}

// 请求html数据、推荐数据、第一页评论
- (void)waterSkyrequestLiveDataRequests {
    kWeakSelf
//    self.htmlLoadDone = YES;
    
    self.htmlLoadDone = NO;
    [self.newsModel waterSkygetClearContentWithBlock:^(BOOL success, NSString *content) {
        weakSelf.htmlContent = content;
        weakSelf.htmlLoadDone = YES;
        NSLog(@"刷新数据成功");
        [weakSelf waterSkyrefreshUI];
    }];
}


#pragma mark - UI refresh
- (void)waterSkysetupViews {
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
    [self.tableView registerNib:[UINib nibWithNibName:@"SkyBallHetiRedHTNewsWebCell" bundle:nil]
         forCellReuseIdentifier:@"SkyBallHetiRedHTNewsWebCell"];
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
    self.tableView.mj_header = [SkyBallHetiRedMJRefreshGenerator bj_headerWithRefreshingBlock:^{
        NSLog(@"bj_headerWithRefreshingBlock");
         [self waterSkyRequestInitAllData];
    }];

}

- (void)waterSkyrefreshUI {
    
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
    [self.newsModel waterSkyshare];
}



#pragma mark - lazy load
- (SkyBallHetiRedHTCommentGetter *)commentGetter {
    if (!_commentGetter) {
        _commentGetter = [[SkyBallHetiRedHTCommentGetter alloc] initWithPostId:self.post_id];
    }
    return _commentGetter;
}

- (SkyBallHetiRedHTNoCommentFooterView *)noCommentsFooterView {
    if (!_noCommentsFooterView) {
        _noCommentsFooterView = [SkyBallHetiRedHTNoCommentFooterView waterSkyfooterViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
    }
    return _noCommentsFooterView;
}

@end
