#import "YYPackageHTMatchHomeViewController.h"
#import "SundayHTMatchDetailViewController.h"
#import "GGCatHTMatchHomeRequest.h"
#import "YYPackageHTMatchHomeCell.h"
#import "KMonkeyHTMatchHomeGroupHeaderView.h"
#import "GGCatHTDatePickerView.h"
#import "NSDateFormatter+CCCaseGlodBuleDRExtension.h"
#import "UIView+HourseGlodBuleLoading.h"
#import "UIView+PXFunGlodBuleEmptyView.h"
#import "AppDelegate.h"
#import "PXFunConfigCoreUtil.h"

@interface YYPackageHTMatchHomeViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *timeTitleLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *matchList;
@property (nonatomic, strong) NSDate *startDate;
@property (nonatomic, strong) NSDate *endDate;
//@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) BOOL requesting;
@property (nonatomic, strong) NSMutableDictionary *inProgressMatchs;
@property (nonatomic, strong) NSCalendar *calendar;
@end
@implementation YYPackageHTMatchHomeViewController
+ (instancetype)taoviewController {
    return kLoadStoryboardWithName(@"UKRosRedMatchHome");
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
    [GGCatBJLoadingHud showHUDInView:self.view];
}
- (IBAction)onNextButtonTappd:(UIButton *)sender {
    self.startDate = [self.startDate dateByAddingDays:8];
    [GGCatBJLoadingHud showHUDInView:self.view];
}
- (IBAction)onSelectDateButtonTapped:(id)sender {
    kWeakSelf
    [GGCatHTDatePickerView taoshowWithWithDate:self.startDate didTapEnterBlock:^BOOL(NSDate *date) {
        weakSelf.startDate = date;
        [GGCatBJLoadingHud showHUDInView:weakSelf.view];
        return YES;
    }];
}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.matchList.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    MMTodayHTMatchHomeGroupModel *groupModel = self.matchList[section];
    return groupModel.matchList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YYPackageHTMatchHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YYPackageHTMatchHomeCell"];
    MMTodayHTMatchHomeGroupModel *groupModel = self.matchList[indexPath.section];
    [cell taosetupWithMatchModel:groupModel.matchList[indexPath.row] matchType:self.matchType];
    
    
    return cell;
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //用户登录
//    if (!MMTodayHTUserManager.tao_userToken || [@"" isEqualToString:MMTodayHTUserManager.tao_userToken]) {
//        [kWindow showToast:@"請先登入帳號"];
//        return;
//    }
    
    MMTodayHTMatchHomeGroupModel *groupModel = self.matchList[indexPath.section];
    SundayHTMatchDetailViewController *detailVc = [SundayHTMatchDetailViewController taoviewController];
    detailVc.matchModel = groupModel.matchList[indexPath.row];
    [self.navigationController pushViewController:detailVc animated:YES];
    
    [PXFunConfigCoreUtil share].matchType = self.matchType;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (self.matchList.count == 0) {
        return nil;
    }
    KMonkeyHTMatchHomeGroupHeaderView *view = (KMonkeyHTMatchHomeGroupHeaderView *)[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"KMonkeyHTMatchHomeGroupHeaderView"];
    MMTodayHTMatchHomeGroupModel *groupModel = self.matchList[section];
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
    [self.tableView registerNib:[UINib nibWithNibName:@"YYPackageHTMatchHomeCell" bundle:nil]
         forCellReuseIdentifier:@"YYPackageHTMatchHomeCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"KMonkeyHTMatchHomeGroupHeaderView" bundle:nil] forHeaderFooterViewReuseIdentifier:@"KMonkeyHTMatchHomeGroupHeaderView"];
    kWeakSelf
    self.tableView.mj_header = [HourseMJRefreshGenerator bj_headerWithRefreshingBlock:^{
        [weakSelf loadData];
    }];
    self.startDate = [NSDate date];
    [self refreshTimeTitle];
    [self.view showLoadingView];
}
- (void)refreshUI {
    [self.tableView.mj_header endRefreshing];
    [self.view hideLoadingView];
    [GGCatBJLoadingHud hideHUDInView:self.view];
    [self refreshTimeTitle];
    [self.tableView reloadData];
    self.requesting = NO;
}
- (void)setStartDate:(NSDate *)startDate {
    _startDate = startDate;
    _endDate = [self date:_startDate addingDays:7];
    [self startTimer];
    [self loadData];
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
- (void)loadData {
    if (self.requesting) {
        return;
    }
    self.requesting = YES;
    [GGCatHTMatchHomeRequest taorequestWithStartDate:[self ymdWithDate:self.startDate]
                                     endDate:[self ymdWithDate:self.endDate]
                                         competition_id:self.matchType
                                successBlock:^(NSArray<MMTodayHTMatchHomeGroupModel *> *matchList,NSArray<SundayHTMatchHomeModel *> *matchA) {
                                    self.matchList = matchList;
                                    [self.tableView hideEmptyView];
                                    if (matchList.count == 0) {
                                        [self.tableView showEmptyView];
                                        [self refreshUI];
                                    } else {
                                        for (MMTodayHTMatchHomeGroupModel *groupModel in matchList) {
                                            for (SundayHTMatchHomeModel *model in groupModel.matchList) {
                                                if ([model.scheduleStatus isEqualToString:@"InProgress"]) {
                                                    [self.inProgressMatchs setObject:model forKey:model.game_id];
                                                }
                                            }                                            
                                        }
                                        if (self.inProgressMatchs.count == 0) {
                                            [self refreshUI];
                                        } else {
                                            for (SundayHTMatchHomeModel *model in self.inProgressMatchs.allValues) {
                                                [GGCatHTMatchHomeRequest taorequestMatchProgressWithGameId:model.game_id successBlock:^(NSString *game_id, NSString *quarter, NSString *time) {
                                                    SundayHTMatchHomeModel *matchModel = [self.inProgressMatchs objectForKey:game_id];
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
                                } errorBlock:^(SundayBJError *error) {
                                    [self.view hideLoadingView];
                                    [GGCatBJLoadingHud hideHUDInView:self.view];
                                    [self.view showToast:error.msg];
                                    if (self.matchList.count == 0) {
                                        kWeakSelf
                                        [self.tableView showEmptyViewWithTitle:@"獲取失敗，點擊重試" tapBlock:^{
                                            [weakSelf loadData];
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
