#import "GlodBuleHTFilmHomeViewController.h"
#import "GlodBuleHTNewsDetailViewController.h"
#import "GlodBuleHTFilmHomeRequest.h"
#import "GlodBuleHTFilmHomeCell.h"
#import "GlodBuleHTNewsHomeCell.h"
#import "GlodBuleHTAdViewCell.h"

@interface GlodBuleHTFilmHomeViewController ()<UITableViewDelegate, UITableViewDataSource, PLLongMediaTableViewCellDelegate, PLCodeViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) GlodBuleHTFilmHomeRequest *request;
@property (nonatomic, strong) NSArray *filmList;
@property (nonatomic, strong) GlodBuleBJError *error;

//@property (nonatomic, strong) NSArray *mediaArray;
@property (nonatomic, assign) BOOL isFullScreen;

@property (nonatomic, weak) GlodBuleHTFilmHomeCell *playingCell;

@end
@implementation GlodBuleHTFilmHomeViewController
+ (instancetype)taoviewController {
    return kLoadStoryboardWithName(@"SkyBallHetiRedFilmHome");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    [[AVAudioSession sharedInstance] setActive:YES error:nil];
    
    [self setupViews];
    [self loadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (BOOL)prefersStatusBarHidden {
    return self.isFullScreen;
}

- (void)onUIApplication:(BOOL)active {
    if (self.playingCell) {
        [self.playingCell configureVideo:active];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    NSLog(@"GlodBuleHTFilmHomeViewController viewDidAppear");
    [self onUIApplication:YES];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    NSLog(@"GlodBuleHTFilmHomeViewController viewDidDisappear");
    [self stop];
    [self onUIApplication:NO];
}

- (void)stop {
    
    NSArray *array = [self.tableView visibleCells];

    for (UITableViewCell *tempCell in array) {
        
        if ([tempCell isKindOfClass:[GlodBuleHTFilmHomeCell class]]) {
            GlodBuleHTFilmHomeCell *xxTempCell = (GlodBuleHTFilmHomeCell *)tempCell;
            [xxTempCell stop];//所有其他不播放的可见cell stop
        }
//        [cell stop];
    }
}

// 根据cell的位置，决定播放哪个cell
- (void)playTopCell {
    
    if (self.playingCell) return;
    
    NSArray *array = [self.tableView visibleCells];
    
    GlodBuleHTFilmHomeCell *playCell = nil;
    CGFloat minOriginY = self.view.bounds.size.height;
    CGFloat navigationBarHeight = 20 + self.navigationController.navigationBar.bounds.size.height;
    for (GlodBuleHTFilmHomeCell *cell in array) {
        CGRect rc = [self.tableView convertRect:cell.frame toView:self.view];
        rc.size.height -= [GlodBuleHTFilmHomeCell headerViewHeight];
        if (rc.origin.y > navigationBarHeight && rc.origin.y + rc.size.height < self.view.bounds.size.height) {
            if (rc.origin.y < minOriginY) {
                minOriginY = rc.origin.y;
                playCell = cell;
            }
            break;
        }
    }
    
    self.playingCell = playCell;
    [playCell play];
}

- (void)tableViewWillPlay:(GlodBuleHTFilmHomeCell *)cell {
    if (cell == self.playingCell) return;
    
    NSArray *array = [self.tableView visibleCells];
    for (UITableViewCell *tempCell in array) {
        
        if (cell != tempCell && [tempCell isKindOfClass:[GlodBuleHTFilmHomeCell class]]) {
            GlodBuleHTFilmHomeCell *xxTempCell = (GlodBuleHTFilmHomeCell *)tempCell;
            [xxTempCell stop];//所有其他不播放的可见cell stop
        }
    }
    self.playingCell = cell;
}

- (void)tableViewCellEnterFullScreen:(GlodBuleHTFilmHomeCell *)cell {
    self.isFullScreen = YES;
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)tableViewCellExitFullScreen:(GlodBuleHTFilmHomeCell *)cell {
    self.isFullScreen = NO;
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    NSLog(@"scrollViewDidEndDragging");
    if (decelerate) return;
    if (nil == self.playingCell) {
//        [self playTopCell];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSLog(@"scrollViewDidEndDecelerating");
    if (nil == self.playingCell) {
//        [self playTopCell];
    }
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
    [cell taosetupWithNewsModel: model];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    cell.backgroundColor = [UIColor whiteColor];

    return cell;
}

- (void)codeViewController:(PLQRCodeViewController *)codeController scanResult:(NSString *)result {
    if (!result) return;
    PLPlayViewController *playController = [[PLPlayViewController alloc] init];
    playController.url = [NSURL URLWithString:result];
    [self presentViewController:playController animated:YES completion:nil];

}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([cell isKindOfClass:[GlodBuleHTFilmHomeCell class]] && cell == self.playingCell) {
        [self.playingCell stop];
        self.playingCell = nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    GlodBuleHTNewsModel *model = self.filmList[indexPath.row];
    if ([model.news_type isEqualToString:@"新聞"]) {
        return 90;
    }else if ([model.news_id isEqualToString:@"-100"]) {
        return 250;
    }
    return [GlodBuleHTFilmHomeCell headerViewHeight];
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
        
        GlodBuleHTNewsModel *m = dataList[i];
        if (m.play_url && ![m.play_url isEqualToString:@""]) {
            m.news_type = @"影片";
        }
        if (!m.plMediaInfo) {
            [m initPLMediaInfo];
        }
        [tmpArray addObject:m];
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
