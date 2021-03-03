#import "GlodBuleHTFilmHomeViewController.h"
#import "GlodBuleHTNewsDetailViewController.h"
#import "GlodBuleHTFilmHomeRequest.h"
#import "GlodBuleHTFilmHomeCell.h"
#import "GlodBuleHTNewsHomeCell.h"
#import "GlodBuleHTAdViewCell.h"

@interface GlodBuleHTFilmHomeViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) GlodBuleHTFilmHomeRequest *request;
@property (nonatomic, strong) NSArray *filmList;
@property (nonatomic, strong) GlodBuleBJError *error;
@end
@implementation GlodBuleHTFilmHomeViewController
+ (instancetype)taoviewController {
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
    GlodBuleHTNewsModel *model = self.filmList[indexPath.row];
    if ([model.news_type isEqualToString:@"新聞"]) {
        GlodBuleHTNewsHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GlodBuleHTNewsHomeCell"];
        [cell taosetupWithNewsModel:model];
        return cell;
    }else if ([model.news_id isEqualToString:@"-100"]) {
        GlodBuleHTAdViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GlodBuleHTAdViewCell"];
        [cell requestAd:self];
        return cell;
    }
    GlodBuleHTFilmHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GlodBuleHTFilmHomeCell"];
    [cell taosetupWithNewsModel:self.filmList[indexPath.row]];
    return cell;
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    GlodBuleHTNewsModel *model = self.filmList[indexPath.row];
    if ([model.news_type isEqualToString:@"新聞"]) {
        return 90;
    }else if ([model.news_id isEqualToString:@"-100"]) {
        return 250;
    }
    return model.filmCellHeight;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    GlodBuleHTNewsModel *newsModel = self.filmList[indexPath.row];
    if ([newsModel.news_id isEqualToString:@"-100"]) {
        return;
    }
    
    GlodBuleHTNewsDetailViewController *detailVc = [GlodBuleHTNewsDetailViewController taoviewController];
    detailVc.post_id = newsModel.news_id;
    [self.navigationController pushViewController:detailVc animated:YES];
}

-(NSArray *) dataWithAd:(NSArray *)dataList{
    NSMutableArray *tmpArray = [NSMutableArray array];
    
    for (int i = 0; i < dataList.count; i++ ) {
        if (i==2) {
            GlodBuleHTNewsModel *adModel = [[GlodBuleHTNewsModel alloc] init];
            adModel.news_id = @"-100";
            [tmpArray addObject:adModel];
        }else if ((i - 2) % 6 == 0){
            GlodBuleHTNewsModel *adModel = [[GlodBuleHTNewsModel alloc] init];
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
    [self.tableView registerNib:[UINib nibWithNibName:@"GlodBuleHTFilmHomeCell" bundle:nil]
         forCellReuseIdentifier:@"GlodBuleHTFilmHomeCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"GlodBuleHTNewsHomeCell" bundle:nil]
         forCellReuseIdentifier:@"GlodBuleHTNewsHomeCell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"GlodBuleHTAdViewCell" bundle:nil]
    forCellReuseIdentifier:@"GlodBuleHTAdViewCell"];
    
    kWeakSelf
    self.tableView.mj_header = [GlodBuleMJRefreshGenerator bj_headerWithRefreshingBlock:^{
        [weakSelf loadData];
    }];
    self.tableView.mj_footer = [GlodBuleMJRefreshGenerator bj_foorterWithRefreshingBlock:^{
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
    [self.request taorequestWithSuccessBlock:^(NSArray<GlodBuleHTNewsModel *> *newsList) {
        weakSelf.filmList = [self dataWithAd:newsList];
        [weakSelf refreshUI];
    } errorBlock:^(GlodBuleBJError *error) {
        weakSelf.error = error;
        [weakSelf refreshUI];
    }];
}
- (void)loadNextPage {
    kWeakSelf
    [self.request loadNextPageWithSuccessBlock:^(NSArray<GlodBuleHTNewsModel *> *newsList) {
        weakSelf.filmList = [self dataWithAd:newsList];
        [weakSelf refreshUI];
    } errorBlock:^(GlodBuleBJError *error) {
        [weakSelf refreshUI];
    }];
}
#pragma mark - lazy load
- (GlodBuleHTFilmHomeRequest *)request {
    if (!_request) {
        _request = [[GlodBuleHTFilmHomeRequest alloc] init];
    }
    return _request;
}
@end