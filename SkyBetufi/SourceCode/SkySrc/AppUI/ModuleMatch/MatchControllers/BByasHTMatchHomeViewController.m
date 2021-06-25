#import "BByasHTMatchHomeViewController.h"
#import "CfipyHTMatchDetailViewController.h"
#import "UUaksHTMatchHomeRequest.h"
#import "MMoogHTMatchHomeCell.h"
#import "BByasHTMatchHomeGroupHeaderView.h"
#import "BByasHTDatePickerView.h"
#import "NSDateFormatter+FFlaliDRExtension.h"
#import "UIView+TuTuosLoading.h"
#import "UIView+CfipyEmptyView.h"
#import "AppDelegate.h"
#import "UUaksConfigCoreUtil.h"
#import "KSasxHTMatchHomeCell222.h"

@interface BByasHTMatchHomeViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *timeTitleLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *matchList;
@property (nonatomic, strong) NSDate *startDate;
@property (nonatomic, strong) NSDate *endDate;

@property (nonatomic, strong) NSDate *loadStartDate;
@property (nonatomic, strong) NSDate *loadEndDate;

//@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) BOOL requesting;
@property (nonatomic, strong) NSMutableDictionary *inProgressMatchs;
@property (nonatomic, strong) NSCalendar *calendar;

@property (nonatomic, assign) NSInteger requestType;

@end
@implementation BByasHTMatchHomeViewController
+ (instancetype)taoviewController {
    return kLoadStoryboardWithName(@"FaCaiMatchHome");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViews];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
//    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    if (app.pushInfo) {
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [app responsePushInfo:app.pushInfo fromViewController:self];
//            app.pushInfo = nil;
//        });
//    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (IBAction)onPreviousButtonTapped:(UIButton *)sender {
    self.startDate = [self.startDate dateBySubtractingDays:8];
    [UUaksBJLoadingHud showHUDInView:self.view];
}
- (IBAction)onNextButtonTappd:(UIButton *)sender {
    self.startDate = [self.startDate dateByAddingDays:8];
    [UUaksBJLoadingHud showHUDInView:self.view];
}
- (IBAction)onSelectDateButtonTapped:(id)sender {
    kWeakSelf
    [BByasHTDatePickerView taoshowWithWithDate:self.startDate didTapEnterBlock:^BOOL(NSDate *date) {
        weakSelf.startDate = date;
        [UUaksBJLoadingHud showHUDInView:weakSelf.view];
        return YES;
    }];
}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.matchList.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    YeYeeHTMatchHomeGroupModel *groupModel = self.matchList[section];
    return groupModel.matchList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (isAppInView) {
        KSasxHTMatchHomeCell222 *cell = [tableView dequeueReusableCellWithIdentifier:@"KSasxHTMatchHomeCell222"];
        YeYeeHTMatchHomeGroupModel *groupModel = self.matchList[indexPath.section];
        [cell taosetupWithMatchModel:groupModel.matchList[indexPath.row] matchType:self.matchType];
        return cell;
    }
    
    MMoogHTMatchHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MMoogHTMatchHomeCell"];
    YeYeeHTMatchHomeGroupModel *groupModel = self.matchList[indexPath.section];
    [cell taosetupWithMatchModel:groupModel.matchList[indexPath.row] matchType:self.matchType];
    
    
    return cell;
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //用户登录
//    if (!TuTuosHTUserManager.tao_userToken || [@"" isEqualToString:TuTuosHTUserManager.tao_userToken]) {
//        [kWindow showToast:@"請先登入帳號"];
//        return;
//    }
    
    YeYeeHTMatchHomeGroupModel *groupModel = self.matchList[indexPath.section];
    CfipyHTMatchDetailViewController *detailVc = [CfipyHTMatchDetailViewController taoviewController];
    detailVc.matchModel = groupModel.matchList[indexPath.row];
    [self.navigationController pushViewController:detailVc animated:YES];
    
    [UUaksConfigCoreUtil share].matchType = self.matchType;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (self.matchList.count == 0) {
        return nil;
    }
    BByasHTMatchHomeGroupHeaderView *view = (BByasHTMatchHomeGroupHeaderView *)[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"BByasHTMatchHomeGroupHeaderView"];
    YeYeeHTMatchHomeGroupModel *groupModel = self.matchList[section];
    view.name = groupModel.groupName;
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (self.matchList.count == 0) {
        return 0.1;
    }
    return 30;
}
#pragma mark - private
- (void)setupViews {
    
//    self.title = @"比賽";
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 130;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self.tableView registerNib:[UINib nibWithNibName:@"MMoogHTMatchHomeCell" bundle:nil]
         forCellReuseIdentifier:@"MMoogHTMatchHomeCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"BByasHTMatchHomeGroupHeaderView" bundle:nil] forHeaderFooterViewReuseIdentifier:@"BByasHTMatchHomeGroupHeaderView"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"KSasxHTMatchHomeCell222" bundle:nil]
         forCellReuseIdentifier:@"KSasxHTMatchHomeCell222"];
    
    kWeakSelf
    self.tableView.mj_header = [YeYeeMJRefreshGenerator bj_headerWithRefreshingBlock:^{
        [weakSelf loadPreviousDateData];
    }];
    
    self.tableView.mj_footer = [YeYeeMJRefreshGenerator bj_foorterWithRefreshingBlock:^{
        [weakSelf loadNextDateData];
    }];
    
//    self.startDate = [NSDate date];
    self.matchList = [NSMutableArray array];
    [self loadCurrentDateData:[NSDate date]];
    [self refreshTimeTitle];
    [self.view showLoadingView];
}
- (void)refreshUI {
    
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    
    [self.view hideLoadingView];
    [self.view hideEmptyView];
    
    [UUaksBJLoadingHud hideHUDInView:self.view];
    [self refreshTimeTitle];
    [self.tableView reloadData];
    self.requesting = NO;
    
    if (self.requestType == 0 && self.matchList.count > 3) {//滚动到指定位置
        
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:2] atScrollPosition:(UITableViewScrollPositionTop) animated:NO];
    }
}
//- (void)setStartDate:(NSDate *)startDate {
////    _startDate = startDate;
//    _startDate = [startDate dateBySubtractingDays:2];
//    _endDate = [self date:startDate addingDays:7];
//    [self startTimer];
//    [self loadData];
//}

- (void)loadCurrentDateData:(NSDate *)startDate {
    self.loadStartDate = [startDate dateBySubtractingDays:2];
    self.loadEndDate = [self date:startDate addingDays:7];
    
    self.startDate = self.loadStartDate;
    self.endDate = self.loadEndDate;
    
    [self startTimer];
    [self loadDataType:0];
}

- (void)loadPreviousDateData {
    self.loadEndDate = [self.startDate dateBySubtractingDays:1];
    self.loadStartDate = [self.loadEndDate dateBySubtractingDays:7];
    [self startTimer];
    [self loadDataType:-1];
    
}

- (void)loadNextDateData {
    
    self.loadStartDate = [self date:self.endDate addingDays:1];
    self.loadEndDate = [self date:self.loadStartDate addingDays:7];
   
    [self startTimer];
    [self loadDataType:1];
}

- (void)startTimer {
//    if ([self notContainToday]) {
//        [self stopTimer];
//        return;
//    }
//    if (self.timer) {
//        return;
//    }
//    self.timer = [NSTimer scheduledTimerWithTimeInterval:10.0
//                                                  target:self
//                                                selector:@selector(loadData)
//                                                userInfo:nil
//                                                 repeats:YES];
}
- (void)stopTimer {
//    [self.timer invalidate];
//    self.timer = nil;
}
- (BOOL)notContainToday {
    NSInteger days = [self numbersOfDayFromDate:self.startDate toDate:[NSDate date]] >= 7;
    if (days >= 7 || days <= -1) { 
        return YES;
    }
    return NO;
}
- (NSDate *)midnightWithDate:(NSDate *)date {
    NSDateComponents *cmp = [self.calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    [cmp setHour:0];
    [cmp setMinute:0];
    [cmp setSecond:0];
    return [self.calendar dateFromComponents:cmp];
}
- (NSInteger)numbersOfDayFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate {
    NSDateComponents *cmp = [self.calendar components:NSCalendarUnitDay
                                             fromDate:[self midnightWithDate:fromDate]
                                               toDate:[self midnightWithDate:toDate]
                                              options:0];
    return cmp.day;
}
- (NSDate *)date:(NSDate *)date addingDays:(NSInteger)dDays {
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setDay:dDays];
    NSDate *newDate = [self.calendar dateByAddingComponents:dateComponents toDate:date options:0];
    return newDate;
}
- (void)loadDataType:(NSInteger)type {
    if (self.requesting) {
        return;
    }
    self.requesting = YES;
    [UUaksHTMatchHomeRequest taorequestWithStartDate:[self ymdWithDate:self.loadStartDate]
                                     endDate:[self ymdWithDate:self.loadEndDate]
                                         competition_id:self.matchType
                                successBlock:^(NSArray<YeYeeHTMatchHomeGroupModel *> *matchList,NSArray<TuTuosHTMatchHomeModel *> *matchA) {
//                                    self.matchList = matchList;
        self.requestType = type;
        if (type == -1) {
            self.startDate = self.loadStartDate;
        }else if (type == 1){
            self.endDate = self.loadEndDate;
        }else{
            self.startDate = self.loadStartDate;
            self.endDate = self.loadEndDate;
        }
   
                                    [self.tableView hideEmptyView];
                                    if (matchList.count == 0) {
//                                        [self.tableView showEmptyView];
                                        [self refreshUI];
                                        
                                        if (self.matchList.count == 0) {
                                            kWeakSelf
                                            [self.tableView showEmptyViewWithTitle:@"獲取失敗，點擊重試" tapBlock:^{
                                                [weakSelf loadDataType:type];
                                                [weakSelf.tableView hideEmptyView];
                                                [weakSelf.view showLoadingView];
                                            }];
                                        }
                                
                                        
                                    } else {
                                        
                                        NSMutableArray<YeYeeHTMatchHomeGroupModel *> *tempMatchList = [NSMutableArray array];
                                        for (YeYeeHTMatchHomeGroupModel *groupModel in matchList) {
                                            for (TuTuosHTMatchHomeModel *model in groupModel.matchList) {
                                                if ([model.scheduleStatus isEqualToString:@"InProgress"]) {
                                                    [self.inProgressMatchs setObject:model forKey:model.game_id];
                                                }
                                            }
                                            [tempMatchList addObject:groupModel];
                                            
                                        }
                                        
                                        if (type == -1) {//向前
                                            
                                            [tempMatchList addObjectsFromArray:self.matchList];
                                            self.matchList = tempMatchList;
                                            
                                        }else if (type == 1){//向后
                                            
                                            [self.matchList addObjectsFromArray:tempMatchList];
                                            
                                        }else{
                                            [self.matchList removeAllObjects];
                                            [self.matchList addObjectsFromArray:tempMatchList];
                                        }

                                        if (self.inProgressMatchs.count == 0) {
                                            [self refreshUI];
                                        } else {
                                            for (TuTuosHTMatchHomeModel *model in self.inProgressMatchs.allValues) {//加载正在比赛中的数据
                                                [UUaksHTMatchHomeRequest taorequestMatchProgressWithGameId:model.game_id successBlock:^(NSString *game_id, NSString *quarter, NSString *time) {
                                                    TuTuosHTMatchHomeModel *matchModel = [self.inProgressMatchs objectForKey:game_id];
                                                    matchModel.quarter = [NSString stringWithFormat:@"第%@節", quarter];
                                                    matchModel.quarter_time = time;
                                                    [self.inProgressMatchs removeObjectForKey:matchModel.game_id];
                                                    if (self.inProgressMatchs.count == 0) {
                                                        [self refreshUI];
                                                    }
                                                } errorBlock:nil];
                                            }
                                        }
                                    }
                                } errorBlock:^(WSKggBJError *error) {
                                    [self.view hideLoadingView];
                                    [UUaksBJLoadingHud hideHUDInView:self.view];
                                    [self.view showToast:error.msg];
                                    if (self.matchList.count == 0) {
                                        kWeakSelf
                                        [self.tableView showEmptyViewWithTitle:@"獲取失敗，點擊重試" tapBlock:^{
                                            [weakSelf loadDataType:type];
                                            [weakSelf.tableView hideEmptyView];
                                            [weakSelf.view showLoadingView];
                                        }];
                                    }
                                    self.requesting = NO;
                                }];
}
- (NSString *)ymdWithDate:(NSDate *)date {
    NSDateFormatter *formt = [NSDateFormatter dr_dateFormatter];
    [formt setDateFormat:@"yyyy-MM-dd"];
    return [formt stringFromDate:date];
}
- (NSString *)mdWithDate:(NSDate *)date {
    NSDateFormatter *formt = [NSDateFormatter dr_dateFormatter];
    [formt setDateFormat:@"MM-dd"];
    return [formt stringFromDate:date];
}
- (void)refreshTimeTitle {
    self.timeTitleLabel.text = [NSString stringWithFormat:@"%@至%@", [self mdWithDate:self.startDate], [self mdWithDate:self.endDate]];
}
- (NSMutableDictionary *)inProgressMatchs {
    if (!_inProgressMatchs) {
        _inProgressMatchs = [NSMutableDictionary dictionary];
    }
    return _inProgressMatchs;
}
- (NSCalendar *)calendar {
    if (!_calendar) {
        _calendar = [NSCalendar currentCalendar];
    }
    return _calendar;
}
@end
