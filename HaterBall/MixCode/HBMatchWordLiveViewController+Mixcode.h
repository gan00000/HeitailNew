#import "HBBJBaseViewController.h"
#import "HBMatchLiveFeedModel.h"
#import "HBMatchWordLiveViewController.h"
#import "HBMatchLiveFeedCell.h"

@interface HBMatchWordLiveViewController (Mixcode)
+ (void)viewControllerMixcode:(NSString *)mixcode;
- (void)viewDidLoadMixcode:(NSString *)mixcode;
- (void)deallocMixcode:(NSString *)mixcode;
- (void)didReceiveMemoryWarningMixcode:(NSString *)mixcode;
- (void)refreshWithLiveFeedList:(NSArray<HBMatchLiveFeedModel *> *)liveFeedList mixcode:(NSString *)mixcode;
- (void)setupViewsMixcode:(NSString *)mixcode;
- (void)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section mixcode:(NSString *)mixcode;
- (void)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath mixcode:(NSString *)mixcode;

@end
