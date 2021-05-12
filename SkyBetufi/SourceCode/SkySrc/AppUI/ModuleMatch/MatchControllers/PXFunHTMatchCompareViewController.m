#import "PXFunHTMatchCompareViewController.h"
#import "KMonkeyHTMatchQuarterCell.h"
#import "RRDogHTMatchPtsCompareCell.h"
#import "YYPackageHTMatchBestPlayerCell.h"
#import "HourseHTScoreViewCell.h"
#import "HourseHTHotShootCellTableViewCell.h"
#import "PXFunHTMatchSummaryRequest.h"
#import "HourseHotShootPointModel.h"

@interface PXFunHTMatchCompareViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, weak) NDeskHTMatchSummaryModel *summaryModel;
@property (nonatomic, weak)NSArray<SundayHTMatchLiveFeedModel *> *liveFeedModel;
@property (nonatomic, weak) PXFunHTMatchCompareModel *matchCompareModel;

@property (nonatomic, weak) SundayHTMatchHomeModel *matchModel;

//@property (nonatomic, strong)NSArray<HourseHotShootPointModel *> *hotShootPointModel_away;
//@property (nonatomic, strong)NSArray<HourseHotShootPointModel *> *hotShootPointModel_home;

@end
@implementation PXFunHTMatchCompareViewController
+ (instancetype)taoviewController {
    return kLoadStoryboardWithName(@"SkyBallHetiRedMatchCompare");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViews];
}
- (void)dealloc {
    NSLog(@"%@ dealloc", NSStringFromClass(self.class));
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)taorefreshWithMatchSummaryModel:(NDeskHTMatchSummaryModel *)summaryModel matchCompareModel:(PXFunHTMatchCompareModel *)matchCompareModel liveFeedModel:(NSArray<SundayHTMatchLiveFeedModel *> *)liveFeedModel matchModel:(SundayHTMatchHomeModel *)matchModel{
    [self.tableView.mj_header endRefreshing];
    self.summaryModel = summaryModel;
    self.liveFeedModel = liveFeedModel;
    self.matchCompareModel = matchCompareModel;
    self.matchModel = matchModel;
        
    /**
    if (!self.hotShootPointModel_away) {//第一次需要加载  home_away主客队 1-主队 2-客队
        [PXFunHTMatchSummaryRequest getShootPointWithGameId:matchModel.game_id home_away:@"2" playerId:@"" quarter:@"" successBlock:^(NSArray<HourseHotShootPointModel *> *model) {
            
            kWeakSelf
            weakSelf.hotShootPointModel_away = model;
            [weakSelf.tableView reloadData];
            
        } errorBlock:^(SundayBJError *error) {
            
        }];
    }
    
    if (!self.hotShootPointModel_home) {//第一次需要加载  home_away主客队 1-主队 2-客队
        [PXFunHTMatchSummaryRequest getShootPointWithGameId:matchModel.game_id home_away:@"1" playerId:@"" quarter:@"" successBlock:^(NSArray<HourseHotShootPointModel *> *model) {
            
            kWeakSelf
            weakSelf.hotShootPointModel_home = model;
            [weakSelf.tableView reloadData];
            
        } errorBlock:^(SundayBJError *error) {
            
        }];
    }
     */
    [self.tableView reloadData];
}
- (void)setupViews {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 40;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([KMonkeyHTMatchQuarterCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([KMonkeyHTMatchQuarterCell class])];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([RRDogHTMatchPtsCompareCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([RRDogHTMatchPtsCompareCell class])];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([YYPackageHTMatchBestPlayerCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([YYPackageHTMatchBestPlayerCell class])];
   
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HourseHTScoreViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([HourseHTScoreViewCell class])];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HourseHTHotShootCellTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([HourseHTHotShootCellTableViewCell class])];
    
    
    kWeakSelf
    self.tableView.mj_header = [HourseMJRefreshGenerator bj_headerWithRefreshingBlock:^{
        if (weakSelf.onTableHeaderRefreshBlock) {
            weakSelf.onTableHeaderRefreshBlock();
        }
    }];
}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        KMonkeyHTMatchQuarterCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([KMonkeyHTMatchQuarterCell class])];
        [cell taosetupWithMatchSummaryModel:self.summaryModel];
        return cell;
    }
    if (indexPath.section == 1) {
        HourseHTScoreViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HourseHTScoreViewCell class])];
        //[cell taosetupWithMatchSummaryModel:self.summaryModel];
        [cell setMatchSummaryModel:self.summaryModel liveFeedModel:self.liveFeedModel];
        return cell;
    }
    if (indexPath.section == 2) {
        RRDogHTMatchPtsCompareCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([RRDogHTMatchPtsCompareCell class])];
        [cell taosetupWithMatchSummaryModel:self.summaryModel];
        return cell;
    }
    if (indexPath.section == 3) {
        YYPackageHTMatchBestPlayerCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([YYPackageHTMatchBestPlayerCell class])];
        [cell taosetupWithMatchSummaryModel:self.summaryModel];
        return cell;
    }
    
    HourseHTHotShootCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HourseHTHotShootCellTableViewCell class])];

//    if (self.hotShootPointModel_away) {
//        [cell updateDataModel:nil summaryModel:self.summaryModel matchCompareModel:self.matchCompareModel gameId:self.matchModel.game_id isLeft:YES];
//
//        [cell setDataModel:nil isLeft:YES width:self.view.width height:self.view.height];
//    }
//    if (self.hotShootPointModel_home) {
//
//        [cell updateDataModel:self.hotShootPointModel_home summaryModel:self.summaryModel matchCompareModel:self.matchCompareModel gameId:self.matchModel.game_id isLeft:NO];
//
//        [cell setDataModel:self.hotShootPointModel_home isLeft:NO width:self.view.width height:self.view.height];
//    }
    
    [cell updateMatchInfoWiithSummaryModel:self.summaryModel matchCompareModel:self.matchCompareModel gameId:self.matchModel.game_id];
    
    [cell updateHotShootDataModel:nil isLeft:YES width:self.view.width height:self.view.height];
    
    return cell;
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 105;
    }
    if (indexPath.section == 1) {
        return 210;
    }
    if (indexPath.section == 2) {
        return 400;
    } if (indexPath.section == 4) {
        return 490;
    }
    return 450;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section > 0) {
        return 10;
    }
    return 0.0001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0001;
}
@end
