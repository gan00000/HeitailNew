#import "HourseHTMainPageViewController.h"
#import "HourseHTNewsDetailViewController.h"
#import "MMTodayHTMainPageHomeRequest.h"
#import "KMonkeyHTMainPageHomeCell.h"
#import "YYPackageHTNewsHomeCell.h"
#import "MMTodayHTAdViewCell.h"
#import "PXFunHTFilmDetailViewController.h"
#import "SunFunly-Swift.h"

@interface HourseHTMainPageViewController ()<UITableViewDelegate, UITableViewDataSource, MainPagePlayerTableViewCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) MMTodayHTMainPageHomeRequest *request;
@property (nonatomic, strong) NSArray *filmList;
@property (nonatomic, strong) SundayBJError *error;

//@property (nonatomic, strong) NSArray *mediaArray;
@property (nonatomic, assign) BOOL isFullScreen;

@property (nonatomic, assign) BOOL playerToDetail;

@property (nonatomic, weak) KMonkeyHTMainPageHomeCell *playingCell;

@end
@implementation HourseHTMainPageViewController
+ (instancetype)taoviewController {
    return kLoadStoryboardWithName(@"UKRosRedMainPage");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    NSLog(@"RRDogHTFilmHomeViewController viewDidAppear");
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
    
    NSLog(@"RRDogHTFilmHomeViewController viewDidDisappear");
    [self playerPause];

}

- (void)playerPause {
    
    NSArray *array = [self.tableView visibleCells];

    for (UITableViewCell *tempCell in array) {
        
        if ([tempCell isKindOfClass:[KMonkeyHTMainPageHomeCell class]]) {
            KMonkeyHTMainPageHomeCell *xxTempCell = (KMonkeyHTMainPageHomeCell *)tempCell;
            
            if (self.playerToDetail && xxTempCell == self.playingCell) {
                
            }else{
                [xxTempCell shutdown];//所有其他不播放的可见cell stop    ..假如播放中的视频需要传递到详情继续播放，则不暂停
            }
            
        }
//        [cell stop];
    }
}

#pragma mark - cell代理PlayerTableViewCellDelegate
- (void)tableViewWillPlay:(KMonkeyHTMainPageHomeCell *)cell {
    if (cell == self.playingCell) return;
    
    NSArray *array = [self.tableView visibleCells];
    for (UITableViewCell *tempCell in array) {
        
        if (cell != tempCell && [tempCell isKindOfClass:[KMonkeyHTMainPageHomeCell class]]) {
            KMonkeyHTMainPageHomeCell *xxTempCell = (KMonkeyHTMainPageHomeCell *)tempCell;
            [xxTempCell shutdown];//所有其他不播放的可见cell stop
        }
    }
    self.playingCell = cell;
}

- (void)tableViewCellEnterFullScreen:(KMonkeyHTMainPageHomeCell *)cell {
    self.isFullScreen = YES;
//    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)tableViewCellExitFullScreen:(KMonkeyHTMainPageHomeCell *)cell {
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
    PXFunHTNewsModel *model = self.filmList[indexPath.row];
    
    KMonkeyHTMainPageHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KMonkeyHTMainPageHomeCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.mPlayerTableViewCellDelegate = self;
    cell.backgroundColor = [UIColor whiteColor];
    [cell taosetupWithNewsModel: model];

    return cell;
    
    
//    if ([model.posted_on isEqualToString:@"videos"]) {
//
//        KMonkeyHTMainPageHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KMonkeyHTMainPageHomeCell"];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        cell.mPlayerTableViewCellDelegate = self;
//        cell.backgroundColor = [UIColor whiteColor];
//        [cell taosetupWithNewsModel: model];
//
//        return cell;
//    }else if ([model.posted_on isEqualToString:@"topics"]) {
//        KMonkeyHTMainPageHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KMonkeyHTMainPageHomeCell"];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        cell.mPlayerTableViewCellDelegate = self;
//        cell.backgroundColor = [UIColor whiteColor];
//        [cell taosetupWithNewsModel:model];
//        return cell;
//    }
//    //news
//    KMonkeyHTMainPageHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KMonkeyHTMainPageHomeCell"];
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    cell.mPlayerTableViewCellDelegate = self;
//    cell.backgroundColor = [UIColor whiteColor];
//    [cell taosetupWithNewsModel:model];
//    return cell;
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    NSLog(@"didEndDisplayingCell");
    
    if ([cell isKindOfClass:[KMonkeyHTMainPageHomeCell class]] && cell == self.playingCell) {
        [self.playingCell stop];
        self.playingCell = nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    PXFunHTNewsModel *model = self.filmList[indexPath.row];
    
    if (!model.hottest_comment || model.hottest_comment.count == 0) {
        return [KMonkeyHTMainPageHomeCell headerViewHeight:70];
    }
    return [KMonkeyHTMainPageHomeCell headerViewHeight:0];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PXFunHTNewsModel *newsModel = self.filmList[indexPath.row];
   
    if ([newsModel.posted_on isEqualToString:@"videos"]) {
        
        PXFunHTFilmDetailViewController *detailVc = [PXFunHTFilmDetailViewController taoviewController];
        detailVc.post_id = newsModel.news_id;
        detailVc.filmModel = newsModel;
        
        if (self.playingCell && [self.playingCell.news_id isEqualToString:newsModel.news_id] && !self.playingCell.playerController.isShutdown && self.playingCell.playerController.player.currentPlaybackTime > 0) {
            detailVc.currentPlaybackTime = self.playingCell.playerController.player.currentPlaybackTime;
            detailVc.cellPlayerController = self.playingCell.playerController;
            [self.playingCell removeCellPlayerView];
            self.playerToDetail = YES;
        }else{
            self.playerToDetail = NO;
        }
        [self.navigationController pushViewController:detailVc animated:YES];
    }else{
        HourseHTNewsDetailViewController *detailVc = [HourseHTNewsDetailViewController taoviewController];
        detailVc.post_id = newsModel.news_id;
        [self.navigationController pushViewController:detailVc animated:YES];
    }
    
}

//-(NSArray *) dataWithAd:(NSArray *)dataList{
//    NSMutableArray *tmpArray = [NSMutableArray array];
//
//    for (int i = 0; i < dataList.count; i++ ) {
//        if (i==2) {
//            PXFunHTNewsModel *adModel = [[PXFunHTNewsModel alloc] init];
//            adModel.news_id = @"-100";
//            [tmpArray addObject:adModel];
//        }else if ((i - 2) % 6 == 0){
//            PXFunHTNewsModel *adModel = [[PXFunHTNewsModel alloc] init];
//            adModel.news_id = @"-100";
//            [tmpArray addObject:adModel];
//        }
//
//        PXFunHTNewsModel *m = dataList[i];
//        if (m.play_url && ![m.play_url isEqualToString:@""]) {
//            m.news_type = @"影片";
//        }
//        if (!m.plMediaInfo) {
//            [m initPLMediaInfo];
//        }
//        [tmpArray addObject:m];
//    }
//
//    return tmpArray;
//
//}

#pragma mark - private
- (void)setupViews {
    self.title = @"首页";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.estimatedRowHeight = 330;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    [self.tableView registerNib:[UINib nibWithNibName:@"KMonkeyHTMainPageHomeCell" bundle:nil]
         forCellReuseIdentifier:@"KMonkeyHTMainPageHomeCell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"YYPackageHTNewsHomeCell" bundle:nil]
         forCellReuseIdentifier:@"YYPackageHTNewsHomeCell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MMTodayHTAdViewCell" bundle:nil]
    forCellReuseIdentifier:@"MMTodayHTAdViewCell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"HotTagScrollCell" bundle:nil]
    forCellReuseIdentifier:@"HotTagScrollCell"];
    
    kWeakSelf
    self.tableView.mj_header = [HourseMJRefreshGenerator bj_headerWithRefreshingBlock:^{
        [weakSelf loadData];
    }];
    self.tableView.mj_footer = [HourseMJRefreshGenerator bj_foorterWithRefreshingBlock:^{
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
    [self.request taorequestWithSuccessBlock:^(NSArray<PXFunHTNewsModel *> *newsList) {
        weakSelf.filmList = newsList;// [self dataWithAd:newsList];
        [weakSelf refreshUI];
    } errorBlock:^(SundayBJError *error) {
        weakSelf.error = error;
        [weakSelf refreshUI];
    }];
}
- (void)loadNextPage {
    kWeakSelf
    [self.request loadNextPageWithSuccessBlock:^(NSArray<PXFunHTNewsModel *> *newsList) {
        weakSelf.filmList = newsList;//[self dataWithAd:newsList];
        [weakSelf refreshUI];
    } errorBlock:^(SundayBJError *error) {
        [weakSelf refreshUI];
    }];
}
#pragma mark - lazy load
- (MMTodayHTMainPageHomeRequest *)request {
    if (!_request) {
        _request = [[MMTodayHTMainPageHomeRequest alloc] init];
    }
    return _request;
}

@end
