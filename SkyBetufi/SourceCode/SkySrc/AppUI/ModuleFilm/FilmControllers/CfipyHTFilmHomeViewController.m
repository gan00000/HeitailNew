#import "CfipyHTFilmHomeViewController.h"
#import "KSasxHTNewsDetailViewController.h"
#import "NSNiceHTFilmHomeRequest.h"
#import "NSNiceHTFilmHomeCell.h"
#import "KSasxHTNewsHomeCell.h"
#import "WSKggHTAdViewCell.h"
#import "KSasxHTFilmDetailViewController.h"

@interface CfipyHTFilmHomeViewController ()<UITableViewDelegate, UITableViewDataSource, PlayerTableViewCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSNiceHTFilmHomeRequest *request;
@property (nonatomic, strong) NSArray *filmList;
@property (nonatomic, strong) WSKggBJError *error;

//@property (nonatomic, strong) NSArray *mediaArray;
@property (nonatomic, assign) BOOL isFullScreen;

@property (nonatomic, assign) BOOL playerToDetail;

@property (nonatomic, weak) NSNiceHTFilmHomeCell *playingCell;

@end
@implementation CfipyHTFilmHomeViewController
+ (instancetype)taoviewController {
    return kLoadStoryboardWithName(@"FaCaiFilmHome");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
//    [[AVAudioSession sharedInstance] setActive:YES error:nil];
    
    [self setupViews];
    [self loadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (BOOL)prefersStatusBarHidden {
    return self.isFullScreen;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSLog(@"CfipyHTFilmHomeViewController viewDidAppear");
//    if (self.filmList) {
//        [self.tableView reloadData];
//    }
    
    if (self.playingCell && self.playerToDetail) {//播放器传递到详情返回的时候，播放view重新添加到cell中，此时不刷新列表（牺牲）
        [self.playingCell reAddCellPlayerView];
    }else{
        if (self.filmList) {
            [self.tableView reloadData];
        }
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    NSLog(@"CfipyHTFilmHomeViewController viewDidDisappear");
    [self playerPause];

}

- (void)playerPause {
    
    NSArray *array = [self.tableView visibleCells];

    for (UITableViewCell *tempCell in array) {
        
        if ([tempCell isKindOfClass:[NSNiceHTFilmHomeCell class]]) {
            NSNiceHTFilmHomeCell *xxTempCell = (NSNiceHTFilmHomeCell *)tempCell;
            
            if (self.playerToDetail && xxTempCell == self.playingCell) {
                
            }else{
                [xxTempCell shutdown];//所有其他不播放的可见cell stop    ..假如播放中的视频需要传递到详情继续播放，则不暂停
            }
            
        }
//        [cell stop];
    }
}

// 根据cell的位置，决定播放哪个cell
//- (void)playTopCell {
//
//    if (self.playingCell) return;
//
//    NSArray *array = [self.tableView visibleCells];
//
//    NSNiceHTFilmHomeCell *playCell = nil;
//    CGFloat minOriginY = self.view.bounds.size.height;
//    CGFloat navigationBarHeight = 20 + self.navigationController.navigationBar.bounds.size.height;
//    for (NSNiceHTFilmHomeCell *cell in array) {
//        CGRect rc = [self.tableView convertRect:cell.frame toView:self.view];
//        rc.size.height -= [NSNiceHTFilmHomeCell headerViewHeight];
//        if (rc.origin.y > navigationBarHeight && rc.origin.y + rc.size.height < self.view.bounds.size.height) {
//            if (rc.origin.y < minOriginY) {
//                minOriginY = rc.origin.y;
//                playCell = cell;
//            }
//            break;
//        }
//    }
//
//    self.playingCell = playCell;
//    [playCell play];
//}

#pragma mark - cell代理PlayerTableViewCellDelegate
- (void)tableViewWillPlay:(NSNiceHTFilmHomeCell *)cell {
    if (cell == self.playingCell) return;
    
    NSArray *array = [self.tableView visibleCells];
    for (UITableViewCell *tempCell in array) {
        
        if (cell != tempCell && [tempCell isKindOfClass:[NSNiceHTFilmHomeCell class]]) {
            NSNiceHTFilmHomeCell *xxTempCell = (NSNiceHTFilmHomeCell *)tempCell;
            [xxTempCell shutdown];//所有其他不播放的可见cell stop
        }
    }
    self.playingCell = cell;
}

- (void)tableViewCellEnterFullScreen:(NSNiceHTFilmHomeCell *)cell {
    self.isFullScreen = YES;
//    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)tableViewCellExitFullScreen:(NSNiceHTFilmHomeCell *)cell {
    self.isFullScreen = NO;
//    [self setNeedsStatusBarAppearanceUpdate];
}


#pragma mark - 1
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
    CfipyHTNewsModel *model = self.filmList[indexPath.row];
    
    if ([model.news_type isEqualToString:@"新聞"]) {
        KSasxHTNewsHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KSasxHTNewsHomeCell"];
        [cell taosetupWithNewsModel:model];
        return cell;
    }else if ([model.news_id isEqualToString:@"-100"]) {
        WSKggHTAdViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WSKggHTAdViewCell"];
        [cell requestAd:self];
        return cell;
    }
    NSNiceHTFilmHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NSNiceHTFilmHomeCell"];
    [cell taosetupWithNewsModel: model];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.mPlayerTableViewCellDelegate = self;
    cell.backgroundColor = [UIColor whiteColor];

    return cell;
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    NSLog(@"didEndDisplayingCell");
    
    if ([cell isKindOfClass:[NSNiceHTFilmHomeCell class]] && cell == self.playingCell) {
        [self.playingCell stop];
        self.playingCell = nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CfipyHTNewsModel *model = self.filmList[indexPath.row];
    if ([model.news_type isEqualToString:@"新聞"]) {
        return KSasxHTNewsHomeCell.xHTNewsHomeCellHeight;
    }else if ([model.news_id isEqualToString:@"-100"]) {
        return 250;
    }
    return [NSNiceHTFilmHomeCell headerViewHeight];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CfipyHTNewsModel *newsModel = self.filmList[indexPath.row];
    if ([newsModel.news_id isEqualToString:@"-100"]) {
        return;
    }
    
    KSasxHTFilmDetailViewController *detailVc = [KSasxHTFilmDetailViewController taoviewController];
    detailVc.post_id = newsModel.news_id;
    detailVc.filmModel = newsModel;
    
//    NSNiceHTFilmHomeCell *selectCell = (NSNiceHTFilmHomeCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    
//    if ([selectCell.news_id isEqualToString:self.playingCell.news_id]) {
//        NSLog(@"selectCell.news_id isEqualToString:self.playingCell.news_id");
//    }
    if (self.playingCell && [self.playingCell.news_id isEqualToString:newsModel.news_id] && !self.playingCell.playerController.isShutdown && self.playingCell.playerController.player.currentPlaybackTime > 0) {
        detailVc.currentPlaybackTime = self.playingCell.playerController.player.currentPlaybackTime;
        detailVc.cellPlayerController = self.playingCell.playerController;
        [self.playingCell removeCellPlayerView];
        self.playerToDetail = YES;
    }else{
        self.playerToDetail = NO;
    }
    [self.navigationController pushViewController:detailVc animated:YES];
}

-(NSArray *) dataWithAd:(NSArray *)dataList{
    NSMutableArray *tmpArray = [NSMutableArray array];
    
    for (int i = 0; i < dataList.count; i++ ) {
        if (i==2) {
            CfipyHTNewsModel *adModel = [[CfipyHTNewsModel alloc] init];
            adModel.news_id = @"-100";
            [tmpArray addObject:adModel];
        }else if ((i - 2) % 6 == 0){
            CfipyHTNewsModel *adModel = [[CfipyHTNewsModel alloc] init];
            adModel.news_id = @"-100";
            [tmpArray addObject:adModel];
        }
        
        CfipyHTNewsModel *m = dataList[i];
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
    self.tableView.estimatedRowHeight = 330;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    [self.tableView registerNib:[UINib nibWithNibName:@"NSNiceHTFilmHomeCell" bundle:nil]
         forCellReuseIdentifier:@"NSNiceHTFilmHomeCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"KSasxHTNewsHomeCell" bundle:nil]
         forCellReuseIdentifier:@"KSasxHTNewsHomeCell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"WSKggHTAdViewCell" bundle:nil]
    forCellReuseIdentifier:@"WSKggHTAdViewCell"];
    
    kWeakSelf
    self.tableView.mj_header = [YeYeeMJRefreshGenerator bj_headerWithRefreshingBlock:^{
        [weakSelf loadData];
    }];
    self.tableView.mj_footer = [YeYeeMJRefreshGenerator bj_foorterWithRefreshingBlock:^{
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
    [self.request taorequestWithSuccessBlock:^(NSArray<CfipyHTNewsModel *> *newsList) {
        weakSelf.filmList = [self dataWithAd:newsList];
        [weakSelf refreshUI];
    } errorBlock:^(WSKggBJError *error) {
        weakSelf.error = error;
        [weakSelf refreshUI];
    }];
}
- (void)loadNextPage {
    kWeakSelf
    [self.request loadNextPageWithSuccessBlock:^(NSArray<CfipyHTNewsModel *> *newsList) {
        weakSelf.filmList = [self dataWithAd:newsList];
        [weakSelf refreshUI];
    } errorBlock:^(WSKggBJError *error) {
        [weakSelf refreshUI];
    }];
}
#pragma mark - lazy load
- (NSNiceHTFilmHomeRequest *)request {
    if (!_request) {
        _request = [[NSNiceHTFilmHomeRequest alloc] init];
    }
    return _request;
}

@end