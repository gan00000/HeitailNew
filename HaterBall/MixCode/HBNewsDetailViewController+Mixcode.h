#import "HBBJBaseViewController.h"
#import "HBNewsModel.h"
#import "HBNewsDetailViewController.h"
#import "HBNewsTopRequest.h"
#import "HBNewsHeaderCell.h"
#import "HBNewsWebCell.h"
#import "HBNewsHomeCell.h"
#import "HBNewsTopHeaderView.h"
#import "HBBJNavigationController.h"

@interface HBNewsDetailViewController (Mixcode)
+ (void)viewControllerMixcode:(NSString *)mixcode;
- (void)viewDidLoadMixcode:(NSString *)mixcode;
- (void)didReceiveMemoryWarningMixcode:(NSString *)mixcode;
- (void)numberOfSectionsInTableView:(UITableView *)tableView mixcode:(NSString *)mixcode;
- (void)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section mixcode:(NSString *)mixcode;
- (void)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath mixcode:(NSString *)mixcode;
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath mixcode:(NSString *)mixcode;
- (void)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath mixcode:(NSString *)mixcode;
- (void)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section mixcode:(NSString *)mixcode;
- (void)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section mixcode:(NSString *)mixcode;
- (void)setupViewsMixcode:(NSString *)mixcode;
- (void)loadDataMixcode:(NSString *)mixcode;
- (void)refreshUIMixcode:(NSString *)mixcode;
- (void)onShareButtonTapped:(id)sender mixcode:(NSString *)mixcode;
- (void)bj_shouldHandlePopActionMySelfMixcode:(NSString *)mixcode;
- (void)bj_handlePopActionMySelfMixcode:(NSString *)mixcode;

@end
