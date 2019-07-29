//
//  XRRFATKHTNewsHomeViewController.m
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/9/8.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import "XRRFATKHTNewsHomeViewController.h"
#import "XRRFATKHTNewsDetailViewController.h"

#import "XRRFATKHTNewsHomeRequest.h"
#import "XRRFATKHTNewsBannerRequest.h"
#import "XRRFATKHTNewsHomeCell.h"
#import "XRRFATKHTNewsHomeBannerCell.h"

@interface XRRFATKHTNewsHomeViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *newsList;
@property (nonatomic, strong) NSArray *bannerList;
@property (nonatomic, strong) XRRFATKHTNewsHomeRequest *request;
@property (nonatomic, strong) XRRFATKBJError *error;
@property (nonatomic, assign) BOOL newsRequestDone;
@property (nonatomic, assign) BOOL bannerRequestDone;

@end

@implementation XRRFATKHTNewsHomeViewController

+ (instancetype)skargviewController {
    return kLoadStoryboardWithName(@"XRRFATKNewsHome");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupViews];
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (!self.bannerRequestDone || !self.newsRequestDone) {
        return 0;
    }
    if (section == 0) {
        return 1;
    }
    return self.newsList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        kWeakSelf
        XRRFATKHTNewsHomeBannerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XRRFATKHTNewsHomeBannerCell"];
        [cell skargsetupWithNewsModels:self.bannerList];
        cell.onBannerTappedBlock = ^(XRRFATKHTNewsModel *newsModel) {
            XRRFATKHTNewsDetailViewController *detailVc = [XRRFATKHTNewsDetailViewController skargviewController];
            detailVc.post_id = newsModel.news_id;
            [weakSelf.navigationController pushViewController:detailVc animated:YES];
        };
        return cell;
    }
    
    XRRFATKHTNewsHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XRRFATKHTNewsHomeCell"];
    [cell skargsetupWithNewsModel:self.newsList[indexPath.row]];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return SCREEN_WIDTH * 2 / 3;
    }
    return 90;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return;
    }
    
    XRRFATKHTNewsModel *newsModel = self.newsList[indexPath.row];
    
    XRRFATKHTNewsDetailViewController *detailVc = [XRRFATKHTNewsDetailViewController skargviewController];
    detailVc.post_id = newsModel.news_id;
    [self.navigationController pushViewController:detailVc animated:YES];
}

#pragma mark - private
- (void)setupViews {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"XRRFATKHTNewsHomeCell" bundle:nil]
         forCellReuseIdentifier:@"XRRFATKHTNewsHomeCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"XRRFATKHTNewsHomeBannerCell" bundle:nil]
         forCellReuseIdentifier:@"XRRFATKHTNewsHomeBannerCell"];
    
    kWeakSelf
    self.tableView.mj_header = [XRRFATKMJRefreshGenerator bj_headerWithRefreshingBlock:^{
        weakSelf.tableView.mj_footer.hidden = YES;
        [weakSelf loadData];
    }];
    
    self.tableView.mj_footer = [XRRFATKMJRefreshGenerator bj_foorterWithRefreshingBlock:^{
        weakSelf.tableView.mj_header.hidden = YES;
        [weakSelf loadNextPage];
    }];
    
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    self.error = nil;
    
    [self.view showLoadingView];
}

- (void)refreshUI {
    if (!self.bannerRequestDone || !self.newsRequestDone) {
        return;
    }
    
    [self.view hideLoadingView];
    [self.view hideEmptyView];
    
    [self.tableView.mj_header endRefreshing];
    if (self.request.hasMore) {
        [self.tableView.mj_footer endRefreshing];
    } else {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    }
    
    if (self.error) {
        if (!self.bannerList || !self.newsList) {
            kWeakSelf
            [self.view showEmptyViewWithTitle:@"獲取失敗，點擊重試" tapBlock:^{
                [weakSelf.view hideEmptyView];
                [weakSelf.view showLoadingView];
                [weakSelf loadData];
            }];
        } else {
            [self.view showToast:self.error.msg];
        }
        self.error = nil;
    }
    
    self.tableView.mj_header.hidden = NO;
    self.tableView.mj_footer.hidden = NO;
    [self.tableView reloadData];
}

- (void)loadData {
    self.bannerRequestDone = NO;
    self.newsRequestDone = NO;
    
    kWeakSelf
    [self.request skargrequestWithSuccessBlock:^(NSArray<XRRFATKHTNewsModel *> *newsList) {
        weakSelf.newsList = newsList;
        weakSelf.newsRequestDone = YES;
        [weakSelf refreshUI];
    } errorBlock:^(XRRFATKBJError *error) {
        weakSelf.error = error;
        weakSelf.newsRequestDone = YES;
        [weakSelf refreshUI];
    }];
    
    [XRRFATKHTNewsBannerRequest skargrequestWithSuccessBlock:^(NSArray<XRRFATKHTNewsModel *> *bannerList) {
        weakSelf.bannerList = bannerList;
        weakSelf.bannerRequestDone = YES;
        [weakSelf refreshUI];
    } errorBlock:^(XRRFATKBJError *error) {
        weakSelf.error = error;
        weakSelf.bannerRequestDone = YES;
        [weakSelf refreshUI];
    }];
}

- (void)loadNextPage {
    self.newsRequestDone = NO;
    
    kWeakSelf
    [self.request skargloadNextPageWithSuccessBlock:^(NSArray<XRRFATKHTNewsModel *> *newsList) {
        weakSelf.newsList = newsList;
        weakSelf.newsRequestDone = YES;
        [weakSelf refreshUI];
     } errorBlock:^(XRRFATKBJError *error) {
         weakSelf.newsRequestDone = YES;
         [weakSelf refreshUI];
     }];
}

#pragma mark - lazy load
- (XRRFATKHTNewsHomeRequest *)request {
    if (!_request) {
        _request = [[XRRFATKHTNewsHomeRequest alloc] init];
    }
    return _request;
}

@end
