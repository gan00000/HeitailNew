#import "HBDataMoreViewController.h"
#import "HBDataPlayerLeftCell.h"
#import "HBDataTeamLeftCell.h"
#import "HBDataPlayerRightCell.h"
#import "HBDataTeamRightCell.h"
#import "HBDataAllRankRequest.h"
@interface HBDataMoreViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *leftTableView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollContentView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftTabelWidth;
@property (nonatomic, strong) UITableView *rightTableView;
@property (nonatomic, strong) NSArray<HBDataPlayerRankModel *> *playerList;
@property (nonatomic, strong) NSArray<HBDataTeamRankModel *> *teamList;
@property (nonatomic, strong) HBBJError *error;
@end
@implementation HBDataMoreViewController
+ (instancetype)viewController {
    return kLoadStoryboardWithName(@"DataMore");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"dddddd"];
    [self.view showLoadingView];
    [self setupLeftTableView];
    [self loadData];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self setupRightTableView];
}
#pragma mark - private
- (void)refreshUI {
    [self.view hideLoadingView];
    [self.view hideEmptyView];
    if (self.error) {
        if ((!self.playerList && self.type == 1) || (!self.teamList && self.type == 2)) {
            kWeakSelf
            [self.view showEmptyViewWithTitle:@"獲取失敗，點擊重試" tapBlock:^{
                [weakSelf.view hideEmptyView];
                [weakSelf.view showLoadingView];
                [weakSelf loadData];
            }];
        } else {
            [self.view showToast:self.error.msg];
        }
        self.error = nil;
    }
    [self.leftTableView reloadData];
    [self.rightTableView reloadData];
}
- (void)loadData {
    if (self.type == 1) {
        [HBDataAllRankRequest requestAllPlayerRankDataWithType:self.subType successBlock:^(NSArray<HBDataPlayerRankModel *> *allPlayerRankList) {
            self.playerList = allPlayerRankList;
            [self refreshUI];
        } errorBlock:^(HBBJError *error) {
            self.error = error;
            [self refreshUI];
        }];
    } else {
        [HBDataAllRankRequest requestAllTeamRankDataWithType:self.subType successBlock:^(NSArray<HBDataTeamRankModel *> *allTeamRankList) {
            self.teamList = allTeamRankList;
            [self refreshUI];
        } errorBlock:^(HBBJError *error) {
            self.error = error;
            [self refreshUI];
        }];
    }
}
- (void)setupLeftTableView {
    self.leftTableView.delegate = self;
    self.leftTableView.dataSource = self;
    self.leftTableView.rowHeight = 30;
    self.leftTableView.sectionHeaderHeight = 40;
    self.leftTableView.sectionFooterHeight = 0;
    self.leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    if (@available(iOS 11.0, *)) {
        self.leftTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    if (self.type == 1) {
        [self.leftTableView registerNib:[UINib nibWithNibName:NSStringFromClass([HBDataPlayerLeftCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([HBDataPlayerLeftCell class])];
    } else {
        [self.leftTableView registerNib:[UINib nibWithNibName:NSStringFromClass([HBDataTeamLeftCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([HBDataTeamLeftCell class])];
    }
}
- (void)setupRightTableView {
    CGFloat width = 1260;
    if (self.type == 2) {
        width = 910;
    } else {
        self.leftTabelWidth.constant = 190;
    }
    [self.scrollContentView setContentSize:CGSizeMake(width, self.leftTableView.jx_height)];
    self.rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, width, self.leftTableView.jx_height) style:UITableViewStylePlain];
    self.rightTableView.backgroundColor = [UIColor whiteColor];
    self.rightTableView.delegate = self;
    self.rightTableView.dataSource = self;
    self.rightTableView.rowHeight = 30;
    self.rightTableView.sectionHeaderHeight = 40;
    self.rightTableView.sectionFooterHeight = 0;
    self.rightTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.rightTableView.bounces = NO;
    self.rightTableView.showsVerticalScrollIndicator = NO;
    self.rightTableView.showsHorizontalScrollIndicator = NO;
    if (@available(iOS 11.0, *)) {
        self.rightTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    if (self.type == 1) {
        [self.rightTableView registerNib:[UINib nibWithNibName:NSStringFromClass([HBDataPlayerRightCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([HBDataPlayerRightCell class])];
    } else {
        [self.rightTableView registerNib:[UINib nibWithNibName:NSStringFromClass([HBDataTeamRightCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([HBDataTeamRightCell class])];
    }
    [self.scrollContentView addSubview:self.rightTableView];
}
- (void)addLabelToView:(UIView *)view withFrame:(CGRect)frame text:(NSString *)text {
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = text;
    label.textColor = [UIColor hx_colorWithHexRGBAString:@"111111"];
    label.font = [UIFont systemFontOfSize:12];
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 2;
    [view addSubview:label];
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.type == 1) {
        return self.playerList.count;
    } else {
        return self.teamList.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.type == 1) {
        HBDataPlayerRankModel *playerModel = self.playerList[indexPath.row];
        if (tableView == self.leftTableView) {
            HBDataPlayerLeftCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HBDataPlayerLeftCell class])];
            [cell refreshWithPlayerModel:playerModel row:indexPath.row];
            return cell;
        }
        HBDataPlayerRightCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HBDataPlayerRightCell class])];
        [cell refreshWithPlayerModel:playerModel row:indexPath.row];
        return cell;
    } else {
        HBDataTeamRankModel *teamModel = self.teamList[indexPath.row];
        if (tableView == self.leftTableView) {
            HBDataTeamLeftCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HBDataTeamLeftCell class])];
            [cell refreshWithTeamModel:teamModel row:indexPath.row];
            return cell;
        }
        HBDataTeamRightCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HBDataTeamRightCell class])];
        [cell refreshWithTeamModel:teamModel row:indexPath.row];
        return cell;
    }
}
#pragma mark - UITableViewDelegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.jx_width, 40)];
    view.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"f4f7f0"];
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 39, tableView.jx_width, 1)];
    line.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"dddddd"];
    [view addSubview:line];
    if (tableView == self.leftTableView) {
        [self addLabelToView:view withFrame:CGRectMake(0, 0, 50, 40) text:@"排名"];
        if (self.type == 1) {
            [self addLabelToView:view withFrame:CGRectMake(50, 0, 140, 40) text:@"球員"];
        } else {
            [self addLabelToView:view withFrame:CGRectMake(50, 0, 100, 40) text:@"球隊"];
        }
    } else {
        NSArray *titles;
        if (self.type == 1) {
            titles = @[@"球隊", @"得分", @"出手數", @"命中率",
                       @"3分出手", @"3分命中率", @"罰球次數", @"罰球命中率",
                       @"籃板", @"前場籃板", @"後場籃板", @"助攻", @"搶斷",
                       @"蓋帽", @"失誤", @"犯規", @"場次", @"上場時間"];
        } else {
            titles = @[@"得分", @"出手數", @"命中率", @"3分出手",
                       @"3分命中率", @"罰球次數", @"罰球命中率", @"籃板",
                       @"助攻", @"搶斷", @"蓋帽", @"犯規", @"場次"];
        }
        for (NSInteger i=0; i<titles.count; i++) {
            [self addLabelToView:view withFrame:CGRectMake(5 + i*70, 0, 60, 40) text:titles[i]];
        }
    }
    return view;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.leftTableView) {
        self.rightTableView.contentOffset = scrollView.contentOffset;
    } else {
        self.leftTableView.contentOffset = scrollView.contentOffset;
    }
}
@end
