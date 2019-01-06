#import "HBBJBaseViewController.h"
#import "HBMatchHomeViewController.h"
#import "HBMatchDetailViewController.h"
#import "HBMatchHomeRequest.h"
#import "HBMatchHomeCell.h"
#import "HBMatchHomeGroupHeaderView.h"
#import "HBDatePickerView.h"
#import "NSDateFormatter+DRExtension.h"
#import "UIView+Loading.h"
#import "UIView+EmptyView.h"

@interface HBMatchHomeViewController (Mixcode)
+ (void)viewControllerMixcode:(NSString *)mixcode;
- (void)viewDidLoadMixcode:(NSString *)mixcode;
- (void)didReceiveMemoryWarningMixcode:(NSString *)mixcode;
- (void)onPreviousButtonTapped:(UIButton *)sender mixcode:(NSString *)mixcode;
- (void)onNextButtonTappd:(UIButton *)sender mixcode:(NSString *)mixcode;
- (void)onSelectDateButtonTapped:(id)sender mixcode:(NSString *)mixcode;
- (void)numberOfSectionsInTableView:(UITableView *)tableView mixcode:(NSString *)mixcode;
- (void)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section mixcode:(NSString *)mixcode;
- (void)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath mixcode:(NSString *)mixcode;
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath mixcode:(NSString *)mixcode;
- (void)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section mixcode:(NSString *)mixcode;
- (void)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section mixcode:(NSString *)mixcode;
- (void)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section mixcode:(NSString *)mixcode;
- (void)setupViewsMixcode:(NSString *)mixcode;
- (void)refreshUIMixcode:(NSString *)mixcode;
- (void)setStartDate:(NSDate *)startDate mixcode:(NSString *)mixcode;
- (void)startTimerMixcode:(NSString *)mixcode;
- (void)stopTimerMixcode:(NSString *)mixcode;
- (void)notContainTodayMixcode:(NSString *)mixcode;
- (void)midnightWithDate:(NSDate *)date mixcode:(NSString *)mixcode;
- (void)numbersOfDayFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate mixcode:(NSString *)mixcode;
- (void)date:(NSDate *)date addingDays:(NSInteger)dDays mixcode:(NSString *)mixcode;
- (void)loadDataMixcode:(NSString *)mixcode;
- (void)ymdWithDate:(NSDate *)date mixcode:(NSString *)mixcode;
- (void)mdWithDate:(NSDate *)date mixcode:(NSString *)mixcode;
- (void)refreshTimeTitleMixcode:(NSString *)mixcode;
- (void)inProgressMatchsMixcode:(NSString *)mixcode;
- (void)calendarMixcode:(NSString *)mixcode;

@end
