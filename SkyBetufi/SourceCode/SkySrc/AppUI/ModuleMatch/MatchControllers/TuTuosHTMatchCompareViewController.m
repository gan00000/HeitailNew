#import "TuTuosHTMatchCompareViewController.h"
#import "BlysaHTMatchQuarterCell.h"
#import "KSasxHTMatchPtsCompareCell.h"
#import "CfipyHTMatchBestPlayerCell.h"
#import "KSasxHTScoreViewCell.h"
#import "NSNiceHTHotShootCellTableViewCell.h"
#import "MMoogHTMatchSummaryRequest.h"
#import "TuTuosHotShootPointModel.h"

@interface TuTuosHTMatchCompareViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, weak) KSasxHTMatchSummaryModel *summaryModel;
@property (nonatomic, weak)NSArray<FFlaliHTMatchLiveFeedModel *> *liveFeedModel;
@property (nonatomic, weak) BByasHTMatchCompareModel *matchCompareModel;

@property (nonatomic, weak) TuTuosHTMatchHomeModel *matchModel;

//@property (nonatomic, strong)NSArray<TuTuosHotShootPointModel *> *hotShootPointModel_away;
//@property (nonatomic, strong)NSArray<TuTuosHotShootPointModel *> *hotShootPointModel_home;

@end
@implementation TuTuosHTMatchCompareViewController
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
- (void)taorefreshWithMatchSummaryModel:(KSasxHTMatchSummaryModel *)summaryModel matchCompareModel:(BByasHTMatchCompareModel *)matchCompareModel liveFeedModel:(NSArray<FFlaliHTMatchLiveFeedModel *> *)liveFeedModel matchModel:(TuTuosHTMatchHomeModel *)matchModel{
    [self.tableView.mj_header endRefreshing];
    self.summaryModel = summaryModel;
    self.liveFeedModel = liveFeedModel;
    self.matchCompareModel = matchCompareModel;
    self.matchModel = matchModel;
        
    /**
    if (!self.hotShootPointModel_away) {//第一次需要加载  home_away主客队 1-主队 2-客队
        [MMoogHTMatchSummaryRequest getShootPointWithGameId:matchModel.game_id home_away:@"2" playerId:@"" quarter:@"" successBlock:^(NSArray<TuTuosHotShootPointModel *> *model) {
            
            kWeakSelf
            weakSelf.hotShootPointModel_away = model;
            [weakSelf.tableView reloadData];
            
        } errorBlock:^(WSKggBJError *error) {
            
        }];
    }
    
    if (!self.hotShootPointModel_home) {//第一次需要加载  home_away主客队 1-主队 2-客队
        [MMoogHTMatchSummaryRequest getShootPointWithGameId:matchModel.game_id home_away:@"1" playerId:@"" quarter:@"" successBlock:^(NSArray<TuTuosHotShootPointModel *> *model) {
            
            kWeakSelf
            weakSelf.hotShootPointModel_home = model;
            [weakSelf.tableView reloadData];
            
        } errorBlock:^(WSKggBJError *error) {
            
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
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([BlysaHTMatchQuarterCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([BlysaHTMatchQuarterCell class])];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([KSasxHTMatchPtsCompareCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([KSasxHTMatchPtsCompareCell class])];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CfipyHTMatchBestPlayerCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([CfipyHTMatchBestPlayerCell class])];
   
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([KSasxHTScoreViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([KSasxHTScoreViewCell class])];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([NSNiceHTHotShootCellTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([NSNiceHTHotShootCellTableViewCell class])];
    
    
    kWeakSelf
    self.tableView.mj_header = [YeYeeMJRefreshGenerator bj_headerWithRefreshingBlock:^{
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
        BlysaHTMatchQuarterCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([BlysaHTMatchQuarterCell class])];
        [cell taosetupWithMatchSummaryModel:self.summaryModel];
        return cell;
    }
    if (indexPath.section == 1) {
        KSasxHTScoreViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([KSasxHTScoreViewCell class])];
        //[cell taosetupWithMatchSummaryModel:self.summaryModel];
        [cell setMatchSummaryModel:self.summaryModel liveFeedModel:self.liveFeedModel];
        return cell;
    }
    if (indexPath.section == 2) {
        KSasxHTMatchPtsCompareCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([KSasxHTMatchPtsCompareCell class])];
        [cell taosetupWithMatchSummaryModel:self.summaryModel];
        return cell;
    }
    if (indexPath.section == 3) {
        CfipyHTMatchBestPlayerCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CfipyHTMatchBestPlayerCell class])];
        [cell taosetupWithMatchSummaryModel:self.summaryModel];
        return cell;
    }
    
    NSNiceHTHotShootCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([NSNiceHTHotShootCellTableViewCell class])];

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
