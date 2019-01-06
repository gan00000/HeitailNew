#import "HBBJBaseViewController.h"
#import "HBRankZoneViewController.h"
#import "HBRankZoneRequest.h"
#import "HBRankHomeCell.h"

@interface HBRankZoneViewController (Mixcode)
+ (void)viewControllerMixcode:(NSString *)mixcode;
- (void)viewDidLoadMixcode:(NSString *)mixcode;
- (void)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section mixcode:(NSString *)mixcode;
- (void)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath mixcode:(NSString *)mixcode;
- (void)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath mixcode:(NSString *)mixcode;
- (void)loadDataMixcode:(NSString *)mixcode;
- (void)refreshUIMixcode:(NSString *)mixcode;
- (void)setupViewsMixcode:(NSString *)mixcode;

@end
