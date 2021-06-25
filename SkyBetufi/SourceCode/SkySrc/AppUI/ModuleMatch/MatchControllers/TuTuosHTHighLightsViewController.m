//
//  TuTuosHTHighLightsViewController.m
//  
//
//  Created by ganyuanrong on 2021/3/12.
//  Copyright © 2021 Dean_F. All rights reserved.
//

#import "TuTuosHTHighLightsViewController.h"
#import "UIColor+FFlaliHex.h"
#import "CfipyHTNewsModel.h"
#import "YeYeeHTNewsHomeRequest.h"
#import "KSasxHTNewsHomeCell.h"

@interface TuTuosHTHighLightsViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong)NSArray<CfipyHTNewsModel *> *newsList;
@property (nonatomic, copy) NSString *game_id;

@property (nonatomic, weak)KSasxHTMatchSummaryModel *mMatchSummaryModel;
@property (nonatomic, weak)BByasHTMatchCompareModel *mMatchCompareModel;

@end

@implementation TuTuosHTHighLightsViewController

+ (instancetype)taoviewController {
    return kLoadStoryboardWithName(@"FaCaiYYPackageHTHighLightsViewController");
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
    [self.tableView registerNib:[UINib nibWithNibName:@"KSasxHTNewsHomeCell" bundle:nil]
         forCellReuseIdentifier:@"KSasxHTNewsHomeCell"];

    
//    kWeakSelf
//    self.tableView.mj_header = [YeYeeMJRefreshGenerator bj_headerWithRefreshingBlock:^{
//        weakSelf.tableView.mj_footer.hidden = YES;
//        [weakSelf loadData];
//    }];
//    self.tableView.mj_footer = [YeYeeMJRefreshGenerator bj_foorterWithRefreshingBlock:^{
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

-(void)refreshDataWithGameId:(NSString *)game_id mMatchSummaryModel:(KSasxHTMatchSummaryModel *)matchModel mCompareModel:(BByasHTMatchCompareModel *)matchCompareModel{
    self.game_id = game_id;
    self.mMatchCompareModel = matchCompareModel;
    self.mMatchSummaryModel = matchModel;
    [self loadData];
}

- (void)loadData {
    
    kWeakSelf
    [YeYeeHTNewsHomeRequest taorequestHighLightWithGameId:self.game_id successBlock:^(NSArray<CfipyHTNewsModel *> *newsList) {
        [self.view hideLoadingView];
        weakSelf.newsList = newsList;
        [weakSelf.tableView reloadData];
       
    } errorBlock:^(WSKggBJError *error) {
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
  
    KSasxHTNewsHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KSasxHTNewsHomeCell"];
    [cell taosetupWithNewsModel:self.newsList[indexPath.row]];
    cell.topLabel.hidden = YES;
    cell.commentLabel.hidden = YES;
    cell.news_time_icon.hidden = YES;
    cell.timeLabel.hidden = YES;
    cell.viewLabel.hidden = YES;
    cell.view_icon.hidden = YES;
    cell.shareButtonContentView.hidden = YES;
    cell.timeLongLabel.hidden = NO;
    
    return cell;
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    return KSasxHTNewsHomeCell.xHTNewsHomeCellHeight;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CfipyHTNewsModel *newsModel = self.newsList[indexPath.row];
    
//    KSasxHTNewsDetailViewController *detailVc = [KSasxHTNewsDetailViewController taoviewController];
//    detailVc.post_id = newsModel.news_id;
//    [self.navigationController pushViewController:detailVc animated:YES];
    
    NSString *webUrl = newsModel.hl_url;//;[NSString stringWithFormat:@"http://app.ballgametime.com/api/nbaschedule.php?token=%@&game_id=%@",token,self.matchModel.game_id];
    
    NSURL *webOpenURL = [NSURL URLWithString:[webUrl stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
    
    if (@available(iOS 10.0, *)) {
        if ([[UIApplication sharedApplication] canOpenURL:webOpenURL]) {
            [[UIApplication sharedApplication] openURL:webOpenURL options:@{} completionHandler:nil];
        }else{
            NSLog(@"can not open canOpenURL: %@",webUrl);
        }
       
    } else {
        // Fallback on earlier versions
        [[UIApplication sharedApplication] openURL:webOpenURL];
    }
}

@end