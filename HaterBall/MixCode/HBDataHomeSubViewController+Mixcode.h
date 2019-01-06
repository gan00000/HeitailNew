#import "HBBJBaseViewController.h"
#import "HBDataHomeSubViewController.h"
#import "HBDataMoreViewController.h"
#import "HBDataHomeRequest.h"
#import "HBDataHomePlayerCell.h"
#import "HBDataHomeTeamCell.h"
#import "HBDataHomeHeaderCell.h"

@interface HBDataHomeSubViewController (Mixcode)
+ (void)viewControllerMixcode:(NSString *)mixcode;
- (void)viewDidLoadMixcode:(NSString *)mixcode;
- (void)didReceiveMemoryWarningMixcode:(NSString *)mixcode;
- (void)numberOfSectionsInTableView:(UITableView *)tableView mixcode:(NSString *)mixcode;
- (void)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section mixcode:(NSString *)mixcode;
- (void)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath mixcode:(NSString *)mixcode;
- (void)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath mixcode:(NSString *)mixcode;
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath mixcode:(NSString *)mixcode;
- (void)setupViewsMixcode:(NSString *)mixcode;
- (void)refreshUIMixcode:(NSString *)mixcode;
- (void)loadDataMixcode:(NSString *)mixcode;

@end
