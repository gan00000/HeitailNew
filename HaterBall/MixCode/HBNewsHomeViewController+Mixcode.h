#import "HBBJBaseViewController.h"
#import "HBNewsHomeViewController.h"
#import "HBNewsDetailViewController.h"
#import "HBNewsHomeRequest.h"
#import "HBNewsBannerRequest.h"
#import "HBNewsHomeCell.h"
#import "HBNewsHomeBannerCell.h"

@interface HBNewsHomeViewController (Mixcode)
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
- (void)loadNextPageMixcode:(NSString *)mixcode;
- (void)requestMixcode:(NSString *)mixcode;

@end
