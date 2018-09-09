//
//  HTNewsDetailViewController.m
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/9/10.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import "HTNewsDetailViewController.h"
#import "HTNewsTopRequest.h"
#import "HTNewsHeaderCell.h"
#import "HTNewsWebCell.h"
#import "HTNewsHomeCell.h"
#import "HTNewsTopHeaderView.h"

@interface HTNewsDetailViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *topNewsList;
@property (nonatomic, assign) CGFloat newsContentHeight;

@end

@implementation HTNewsDetailViewController

+ (instancetype)viewController {
    return kLoadStoryboardWithName(@"NewsDetail");
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
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 2) {
        return self.topNewsList.count;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        HTNewsHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HTNewsHeaderCell"];
        [cell setupWithNewsModel:self.newsModel];
        return cell;
    } else if (indexPath.section == 1) {
        kWeakSelf
        HTNewsWebCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HTNewsWebCell"];
        [cell setupWithNewsModel:self.newsModel];
        cell.onContentHeightUpdateBlock = ^(CGFloat height) {
            if (fabs(height - weakSelf.newsContentHeight) < 1) {
                return;
            }
            weakSelf.newsContentHeight = height;
            [weakSelf.tableView reloadData];
        };
        return cell;
    }
    HTNewsHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HTNewsHomeCell"];
    [cell setupWithNewsModel:self.topNewsList[indexPath.row]];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2) {
        HTNewsModel *newsModel = self.topNewsList[indexPath.row];
        
        HTNewsDetailViewController *detailVc = [HTNewsDetailViewController viewController];
        detailVc.newsModel = newsModel;
        [self.navigationController pushViewController:detailVc animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return self.newsModel.detailHeaderHeight;
    } else if (indexPath.section == 1) {
        return self.newsContentHeight;
    }
    return 90;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 2) {
        return 40;
    }
    return 0;
}

- (UITableViewHeaderFooterView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 2) {
        HTNewsTopHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"HTNewsTopHeaderView"];
        return headerView;
    }
    return nil;
}

#pragma mark - private
- (void)setupViews {
    self.title = @"新聞詳情";
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"HTNewsHeaderCell" bundle:nil]
         forCellReuseIdentifier:@"HTNewsHeaderCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"HTNewsWebCell" bundle:nil]
         forCellReuseIdentifier:@"HTNewsWebCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"HTNewsHomeCell" bundle:nil]
         forCellReuseIdentifier:@"HTNewsHomeCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"HTNewsTopHeaderView" bundle:nil] forHeaderFooterViewReuseIdentifier:@"HTNewsTopHeaderView"];
    
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    self.newsContentHeight = 300;
}

- (void)loadData {
    [HTNewsTopRequest requestWithSuccessBlock:^(NSArray<HTNewsModel *> *newsList) {
        self.topNewsList = newsList;
        [self.tableView reloadData];
    } errorBlock:^(BJError *error) {
        [self.view showToast:error.msg];
    }];
}

@end
