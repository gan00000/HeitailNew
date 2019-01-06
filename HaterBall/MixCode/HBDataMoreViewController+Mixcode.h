#import "HBBJBaseViewController.h"
#import "HBDataMoreViewController.h"
#import "HBDataPlayerLeftCell.h"
#import "HBDataTeamLeftCell.h"
#import "HBDataPlayerRightCell.h"
#import "HBDataTeamRightCell.h"
#import "HBDataAllRankRequest.h"

@interface HBDataMoreViewController (Mixcode)
+ (void)viewControllerMixcode:(NSString *)mixcode;
- (void)viewDidLoadMixcode:(NSString *)mixcode;
- (void)viewDidAppear:(BOOL)animated mixcode:(NSString *)mixcode;
- (void)refreshUIMixcode:(NSString *)mixcode;
- (void)loadDataMixcode:(NSString *)mixcode;
- (void)setupLeftTableViewMixcode:(NSString *)mixcode;
- (void)setupRightTableViewMixcode:(NSString *)mixcode;
- (void)addLabelToView:(UIView *)view withFrame:(CGRect)frame text:(NSString *)text mixcode:(NSString *)mixcode;
- (void)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section mixcode:(NSString *)mixcode;
- (void)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath mixcode:(NSString *)mixcode;
- (void)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section mixcode:(NSString *)mixcode;
- (void)scrollViewDidScroll:(UIScrollView *)scrollView mixcode:(NSString *)mixcode;

@end
