//
//  HTHighLightsViewController.m
//  XXXHeiTai
//
//  Created by ganyuanrong on 2021/3/12.
//  Copyright © 2021 Dean_F. All rights reserved.
//

#import "HTHighLightsViewController.h"
#import "UIColor+GlodBuleHex.h"
#import "GlodBuleHTNewsModel.h"
#import "GlodBuleHTNewsHomeRequest.h"
#import "GlodBuleHTNewsHomeCell.h"

@interface HTHighLightsViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong)NSArray<GlodBuleHTNewsModel *> *newsList;
@property (nonatomic, copy) NSString *game_id;

@end

@implementation HTHighLightsViewController

+ (instancetype)taoviewController {
    return kLoadStoryboardWithName(@"HTHighLightsViewController");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViews];
}

- (void)setupViews {
    //self.title = @"新聞";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    [self.tableView registerNib:[UINib nibWithNibName:@"GlodBuleHTNewsHomeCell" bundle:nil]
         forCellReuseIdentifier:@"GlodBuleHTNewsHomeCell"];

    
//    kWeakSelf
//    self.tableView.mj_header = [GlodBuleMJRefreshGenerator bj_headerWithRefreshingBlock:^{
//        weakSelf.tableView.mj_footer.hidden = YES;
//        [weakSelf loadData];
//    }];
//    self.tableView.mj_footer = [GlodBuleMJRefreshGenerator bj_foorterWithRefreshingBlock:^{
//        weakSelf.tableView.mj_header.hidden = YES;
//        [weakSelf loadNextPage];
//    }];
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self.view showLoadingView];
}

-(void)refreshDataWithGameId:(NSString *)game_id{
    self.game_id = game_id;
    [self loadData];
}

- (void)loadData {
    
    kWeakSelf
    [GlodBuleHTNewsHomeRequest taorequestHighLightWithGameId:self.game_id successBlock:^(NSArray<GlodBuleHTNewsModel *> *newsList) {
        [self.view hideLoadingView];
        weakSelf.newsList = newsList;
        [weakSelf.tableView reloadData];
       
    } errorBlock:^(GlodBuleBJError *error) {
        [self.view hideLoadingView];
    }];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(!self.newsList){
        return 0;
    }
    return self.newsList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"indexPath.section:%ld  indexPath.row:%ld", indexPath.section, indexPath.row);
  
    GlodBuleHTNewsHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GlodBuleHTNewsHomeCell"];
    [cell taosetupWithNewsModel:self.newsList[indexPath.row]];
    cell.topLabel.hidden = YES;
    return cell;
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    return 90;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GlodBuleHTNewsModel *newsModel = self.newsList[indexPath.row];
    
//    GlodBuleHTNewsDetailViewController *detailVc = [GlodBuleHTNewsDetailViewController taoviewController];
//    detailVc.post_id = newsModel.news_id;
//    [self.navigationController pushViewController:detailVc animated:YES];
}

@end
