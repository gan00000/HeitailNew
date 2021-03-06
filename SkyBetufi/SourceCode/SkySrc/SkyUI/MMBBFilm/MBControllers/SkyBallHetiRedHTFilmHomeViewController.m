#import "SkyBallHetiRedHTFilmHomeViewController.h"
#import "SkyBallHetiRedHTNewsDetailViewController.h"
#import "SkyBallHetiRedHTFilmHomeRequest.h"
#import "SkyBallHetiRedHTFilmHomeCell.h"
#import "SkyBallHetiRedHTNewsHomeCell.h"
#import "HTAdViewCell.h"

@interface SkyBallHetiRedHTFilmHomeViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) SkyBallHetiRedHTFilmHomeRequest *request;
@property (nonatomic, strong) NSArray *filmList;
@property (nonatomic, strong) SkyBallHetiRedBJError *error;
@end
@implementation SkyBallHetiRedHTFilmHomeViewController
+ (instancetype)waterSkyviewController {
    return kLoadStoryboardWithName(@"SkyBallHetiRedFilmHome");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViews];
    [self loadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.filmList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SkyBallHetiRedHTNewsModel *model = self.filmList[indexPath.row];
    if ([model.news_type isEqualToString:@"新聞"]) {
        SkyBallHetiRedHTNewsHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SkyBallHetiRedHTNewsHomeCell"];
        [cell waterSkysetupWithNewsModel:model];
        return cell;
    }else if ([model.news_id isEqualToString:@"-100"]) {
        HTAdViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HTAdViewCell"];
        [cell requestAd:self];
        return cell;
    }
    SkyBallHetiRedHTFilmHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SkyBallHetiRedHTFilmHomeCell"];
    [cell waterSkysetupWithNewsModel:self.filmList[indexPath.row]];
    return cell;
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    SkyBallHetiRedHTNewsModel *model = self.filmList[indexPath.row];
    if ([model.news_type isEqualToString:@"新聞"]) {
        return 90;
    }else if ([model.news_id isEqualToString:@"-100"]) {
        return 250;
    }
    return model.filmCellHeight;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SkyBallHetiRedHTNewsModel *newsModel = self.filmList[indexPath.row];
    if ([newsModel.news_id isEqualToString:@"-100"]) {
        return;
    }
    
    SkyBallHetiRedHTNewsDetailViewController *detailVc = [SkyBallHetiRedHTNewsDetailViewController waterSkyviewController];
    detailVc.post_id = newsModel.news_id;
    [self.navigationController pushViewController:detailVc animated:YES];
}

-(NSArray *) dataWithAd:(NSArray *)dataList{
    NSMutableArray *tmpArray = [NSMutableArray array];
    
    for (int i = 0; i < dataList.count; i++ ) {
        if (i==2) {
            SkyBallHetiRedHTNewsModel *adModel = [[SkyBallHetiRedHTNewsModel alloc] init];
            adModel.news_id = @"-100";
            [tmpArray addObject:adModel];
        }else if ((i - 2) % 6 == 0){
            SkyBallHetiRedHTNewsModel *adModel = [[SkyBallHetiRedHTNewsModel alloc] init];
            adModel.news_id = @"-100";
            [tmpArray addObject:adModel];
        }
        
        [tmpArray addObject:dataList[i]];
    }
    
    return tmpArray;
    
}

#pragma mark - private
- (void)setupViews {
    self.title = @"影片";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    [self.tableView registerNib:[UINib nibWithNibName:@"SkyBallHetiRedHTFilmHomeCell" bundle:nil]
         forCellReuseIdentifier:@"SkyBallHetiRedHTFilmHomeCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"SkyBallHetiRedHTNewsHomeCell" bundle:nil]
         forCellReuseIdentifier:@"SkyBallHetiRedHTNewsHomeCell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"HTAdViewCell" bundle:nil]
    forCellReuseIdentifier:@"HTAdViewCell"];
    
    kWeakSelf
    self.tableView.mj_header = [SkyBallHetiRedMJRefreshGenerator bj_headerWithRefreshingBlock:^{
        [weakSelf loadData];
    }];
    self.tableView.mj_footer = [SkyBallHetiRedMJRefreshGenerator bj_foorterWithRefreshingBlock:^{
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
    [self.view hideLoadingView];
    [self.view hideEmptyView];
    [self.tableView.mj_header endRefreshing];
    if (self.request.hasMore) {
        [self.tableView.mj_footer endRefreshing];
    } else {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    }
    if (self.error) {
        if (!self.filmList) {
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
    [self.tableView reloadData];
}
- (void)loadData {
    kWeakSelf
    [self.request waterSkyrequestWithSuccessBlock:^(NSArray<SkyBallHetiRedHTNewsModel *> *newsList) {
        weakSelf.filmList = [self dataWithAd:newsList];
        [weakSelf refreshUI];
    } errorBlock:^(SkyBallHetiRedBJError *error) {
        weakSelf.error = error;
        [weakSelf refreshUI];
    }];
}
- (void)loadNextPage {
    kWeakSelf
    [self.request loadNextPageWithSuccessBlock:^(NSArray<SkyBallHetiRedHTNewsModel *> *newsList) {
        weakSelf.filmList = [self dataWithAd:newsList];
        [weakSelf refreshUI];
    } errorBlock:^(SkyBallHetiRedBJError *error) {
        [weakSelf refreshUI];
    }];
}
#pragma mark - lazy load
- (SkyBallHetiRedHTFilmHomeRequest *)request {
    if (!_request) {
        _request = [[SkyBallHetiRedHTFilmHomeRequest alloc] init];
    }
    return _request;
}
@end
