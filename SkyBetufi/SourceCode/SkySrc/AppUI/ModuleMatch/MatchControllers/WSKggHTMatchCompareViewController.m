#import "WSKggHTMatchCompareViewController.h"
#import "TuTuosHTMatchQuarterCell.h"
#import "BByasHTMatchPtsCompareCell.h"
#import "WSKggHTMatchBestPlayerCell.h"
#import "TuTuosHTScoreViewCell.h"
#import "TuTuosHTHotShootCellTableViewCell.h"
#import "MMoogHTMatchSummaryRequest.h"
#import "BByasHotShootPointModel.h"

@interface WSKggHTMatchCompareViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, weak) NSNiceHTMatchSummaryModel *summaryModel;
@property (nonatomic, weak)NSArray<UUaksHTMatchLiveFeedModel *> *liveFeedModel;
@property (nonatomic, weak) WSKggHTMatchCompareModel *matchCompareModel;

@property (nonatomic, weak) FFlaliHTMatchHomeModel *matchModel;

//@property (nonatomic, strong)NSArray<BByasHotShootPointModel *> *hotShootPointModel_away;
//@property (nonatomic, strong)NSArray<BByasHotShootPointModel *> *hotShootPointModel_home;

@end
@implementation WSKggHTMatchCompareViewController
+ (instancetype)taoviewController {
    return kLoadStoryboardWithName(@"FaCaiMatchCompare");
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
- (void)taorefreshWithMatchSummaryModel:(NSNiceHTMatchSummaryModel *)summaryModel matchCompareModel:(WSKggHTMatchCompareModel *)matchCompareModel liveFeedModel:(NSArray<UUaksHTMatchLiveFeedModel *> *)liveFeedModel matchModel:(FFlaliHTMatchHomeModel *)matchModel{
    [self.tableView.mj_header endRefreshing];
    self.summaryModel = summaryModel;
    self.liveFeedModel = liveFeedModel;
    self.matchCompareModel = matchCompareModel;
    self.matchModel = matchModel;
        
    /**
    if (!self.hotShootPointModel_away) {//第一次需要加载  home_away主客队 1-主队 2-客队
        [MMoogHTMatchSummaryRequest getShootPointWithGameId:matchModel.game_id home_away:@"2" playerId:@"" quarter:@"" successBlock:^(NSArray<BByasHotShootPointModel *> *model) {
            
            kWeakSelf
            weakSelf.hotShootPointModel_away = model;
            [weakSelf.tableView reloadData];
            
        } errorBlock:^(YeYeeBJError *error) {
            
        }];
    }
    
    if (!self.hotShootPointModel_home) {//第一次需要加载  home_away主客队 1-主队 2-客队
        [MMoogHTMatchSummaryRequest getShootPointWithGameId:matchModel.game_id home_away:@"1" playerId:@"" quarter:@"" successBlock:^(NSArray<BByasHotShootPointModel *> *model) {
            
            kWeakSelf
            weakSelf.hotShootPointModel_home = model;
            [weakSelf.tableView reloadData];
            
        } errorBlock:^(YeYeeBJError *error) {
            
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
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TuTuosHTMatchQuarterCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([TuTuosHTMatchQuarterCell class])];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([BByasHTMatchPtsCompareCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([BByasHTMatchPtsCompareCell class])];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([WSKggHTMatchBestPlayerCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([WSKggHTMatchBestPlayerCell class])];
   
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TuTuosHTScoreViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([TuTuosHTScoreViewCell class])];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TuTuosHTHotShootCellTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([TuTuosHTHotShootCellTableViewCell class])];
    
    
    kWeakSelf
    self.tableView.mj_header = [BlysaMJRefreshGenerator bj_headerWithRefreshingBlock:^{
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
        TuTuosHTMatchQuarterCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TuTuosHTMatchQuarterCell class])];
        [cell taosetupWithMatchSummaryModel:self.summaryModel];
        return cell;
    }
    if (indexPath.section == 1) {
        TuTuosHTScoreViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TuTuosHTScoreViewCell class])];
        //[cell taosetupWithMatchSummaryModel:self.summaryModel];
        [cell setMatchSummaryModel:self.summaryModel liveFeedModel:self.liveFeedModel];
        return cell;
    }
    if (indexPath.section == 2) {
        BByasHTMatchPtsCompareCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([BByasHTMatchPtsCompareCell class])];
        [cell taosetupWithMatchSummaryModel:self.summaryModel];
        return cell;
    }
    if (indexPath.section == 3) {
        WSKggHTMatchBestPlayerCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([WSKggHTMatchBestPlayerCell class])];
        [cell taosetupWithMatchSummaryModel:self.summaryModel];
        return cell;
    }
    
    TuTuosHTHotShootCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TuTuosHTHotShootCellTableViewCell class])];

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
