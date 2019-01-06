#import "HBBJBaseViewController.h"
#import "HBMatchDetailsModel.h"
#import "HBMatchSubDsbdViewController.h"
#import "HBMatchDataLeftCell.h"
#import "HBMatchDataRightCell.h"

@interface HBMatchSubDsbdViewController (Mixcode)
+ (void)viewControllerMixcode:(NSString *)mixcode;
- (void)viewDidLoadMixcode:(NSString *)mixcode;
- (void)viewDidAppear:(BOOL)animated mixcode:(NSString *)mixcode;
- (void)setupLeftTableViewMixcode:(NSString *)mixcode;
- (void)setupRightTableViewMixcode:(NSString *)mixcode;
- (void)refreshWithDetailList:(NSArray<HBMatchDetailsModel *> *)detailList mixcode:(NSString *)mixcode;
- (void)addLabelToView:(UIView *)view withFrame:(CGRect)frame text:(NSString *)text mixcode:(NSString *)mixcode;
- (void)countWithDataList:(NSArray<HBMatchDetailsModel *> *)dataList mixcode:(NSString *)mixcode;
- (void)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section mixcode:(NSString *)mixcode;
- (void)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath mixcode:(NSString *)mixcode;
- (void)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section mixcode:(NSString *)mixcode;
- (void)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section mixcode:(NSString *)mixcode;
- (void)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section mixcode:(NSString *)mixcode;
- (void)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section mixcode:(NSString *)mixcode;
- (void)scrollViewDidScroll:(UIScrollView *)scrollView mixcode:(NSString *)mixcode;

@end
