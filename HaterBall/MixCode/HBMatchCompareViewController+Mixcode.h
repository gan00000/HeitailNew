#import "HBBJBaseViewController.h"
#import "HBMatchSummaryModel.h"
#import "HBMatchCompareViewController.h"
#import "HBMatchQuarterCell.h"
#import "HBMatchPtsCompareCell.h"
#import "HBMatchBestPlayerCell.h"

@interface HBMatchCompareViewController (Mixcode)
+ (void)viewControllerMixcode:(NSString *)mixcode;
- (void)viewDidLoadMixcode:(NSString *)mixcode;
- (void)deallocMixcode:(NSString *)mixcode;
- (void)didReceiveMemoryWarningMixcode:(NSString *)mixcode;
- (void)refreshWithMatchSummaryModel:(HBMatchSummaryModel *)summaryModel mixcode:(NSString *)mixcode;
- (void)setupViewsMixcode:(NSString *)mixcode;
- (void)numberOfSectionsInTableView:(UITableView *)tableView mixcode:(NSString *)mixcode;
- (void)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section mixcode:(NSString *)mixcode;
- (void)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath mixcode:(NSString *)mixcode;
- (void)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath mixcode:(NSString *)mixcode;
- (void)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section mixcode:(NSString *)mixcode;
- (void)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section mixcode:(NSString *)mixcode;

@end
