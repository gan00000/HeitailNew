#import "KSasxHTLikeViewController.h"
#import "TuTuosHTUserRequest.h"
#import "UUaksHTMyCommentCell.h"
#import "NSNiceHTNewsDetailViewController.h"
@interface KSasxHTLikeViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<UUaksHTNewsModel *> *dataSource;
@property (nonatomic, assign) NSInteger offset;
@end
@implementation KSasxHTLikeViewController
+ (instancetype)taoviewController {
    return [[KSasxHTLikeViewController alloc] init];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的點讚";
    self.dataSource = [NSMutableArray array];
    [self.view showLoadingView];
    [self loadData];
    [self setupTableView];
}
- (void)loadData {
    [TuTuosHTUserRequest taorequestMyLikeWithOffset:self.offset successBlock:^(NSArray<UUaksHTNewsModel *> * _Nonnull newsList, NSInteger pages) {
        for (UUaksHTNewsModel *model in newsList) {
            [model taocountCommentHeight];
        }
        [self.dataSource addObjectsFromArray:newsList];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        if (pages > self.offset+1) {
            self.offset ++;
            [self.tableView.mj_footer endRefreshing];
            [self.tableView.mj_footer resetNoMoreData];
        } else {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        if (newsList.count == 0) {
            [self.view showEmptyView];
        }
        [self.view hideLoadingView];
    } failBlock:^(YeYeeBJError *error) {
        [self.view hideLoadingView];
        [self.view showEmptyViewWithTitle:@"獲取數據失敗，點擊重試" tapBlock:^{
            [self.view hideEmptyView];
            [self.view showLoadingView];
            [self loadData];
        }];
    }];
}
- (void)reloadData {
    self.offset = 0;
    [self.dataSource removeAllObjects];
    [self loadData];
}
- (void)setupTableView {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.rowHeight = 90;
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self.tableView registerNib:[UINib nibWithNibName:@"UUaksHTMyCommentCell" bundle:nil]
         forCellReuseIdentifier:@"UUaksHTMyCommentCell"];
    kWeakSelf
    self.tableView.mj_header = [BlysaMJRefreshGenerator bj_headerWithRefreshingBlock:^{
        weakSelf.tableView.mj_footer.hidden = YES;
        [weakSelf reloadData];
    }];
    self.tableView.mj_footer = [BlysaMJRefreshGenerator bj_foorterWithRefreshingBlock:^{
        weakSelf.tableView.mj_header.hidden = YES;
        [weakSelf loadData];
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    UUaksHTNewsModel *newsModel = self.dataSource[indexPath.row];
    return newsModel.my_comment_cell_height;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UUaksHTMyCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UUaksHTMyCommentCell"];
    [cell taosetupWithNewsModel:self.dataSource[indexPath.row]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UUaksHTNewsModel *newsModel = self.dataSource[indexPath.row];
    NSNiceHTNewsDetailViewController *detailVc = [NSNiceHTNewsDetailViewController taoviewController];
    detailVc.post_id = newsModel.news_id;
    [self.navigationController pushViewController:detailVc animated:YES];
}
@end
