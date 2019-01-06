#import "HBMatchSubDsbdViewController.h"
#import "HBMatchDataLeftCell.h"
#import "HBMatchDataRightCell.h"
@interface HBMatchSubDsbdViewController ()<UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *leftTableView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollContentView;
@property (nonatomic, strong) UITableView *rightTableView;
@property (nonatomic, weak) NSArray<HBMatchDetailsModel *> *dataList;
@property (nonatomic, strong) NSMutableArray *counts;
@end
@implementation HBMatchSubDsbdViewController
+ (instancetype)viewController {
    return kLoadStoryboardWithName(@"MatchSubDsbd");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"dddddd"];
    [self setupLeftTableView];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self setupRightTableView];
}
- (void)setupLeftTableView {
    self.leftTableView.delegate = self;
    self.leftTableView.dataSource = self;
    self.leftTableView.rowHeight = 30;
    self.leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    if (@available(iOS 11.0, *)) {
        self.leftTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self.leftTableView registerNib:[UINib nibWithNibName:NSStringFromClass([HBMatchDataLeftCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([HBMatchDataLeftCell class])];
}
- (void)setupRightTableView {
    [self.scrollContentView setContentSize:CGSizeMake(1050, self.leftTableView.jx_height)];
    self.rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 1050, self.leftTableView.jx_height) style:UITableViewStylePlain];
    self.rightTableView.backgroundColor = [UIColor whiteColor];
    self.rightTableView.delegate = self;
    self.rightTableView.dataSource = self;
    self.rightTableView.rowHeight = 30;
    self.rightTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.rightTableView.bounces = NO;
    self.rightTableView.showsVerticalScrollIndicator = NO;
    self.rightTableView.showsHorizontalScrollIndicator = NO;
    if (@available(iOS 11.0, *)) {
        self.rightTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    [self.rightTableView registerNib:[UINib nibWithNibName:NSStringFromClass([HBMatchDataRightCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([HBMatchDataRightCell class])];
    [self.scrollContentView addSubview:self.rightTableView];
}
- (void)refreshWithDetailList:(NSArray<HBMatchDetailsModel *> *)detailList {
    self.dataList = detailList;
    [self countWithDataList:detailList];
    [self.leftTableView reloadData];
    [self.rightTableView reloadData];
}
- (void)addLabelToView:(UIView *)view withFrame:(CGRect)frame text:(NSString *)text {
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = text;
    label.textColor = [UIColor hx_colorWithHexRGBAString:@"111111"];
    label.font = [UIFont systemFontOfSize:12];
    label.textAlignment = NSTextAlignmentCenter;
    [view addSubview:label];
}
- (void)countWithDataList:(NSArray<HBMatchDetailsModel *> *)dataList {
    if (dataList.count == 0) {
        return;
    }
    if (!self.counts) {
        self.counts = [NSMutableArray array];
    }
    [self.counts removeAllObjects];
    NSInteger pts = 0;
    NSInteger ast = 0;
    NSInteger reb = 0;
    NSInteger fgatt = 0;
    NSInteger fgmate = 0;
    NSInteger fg3att = 0;
    NSInteger fg3mate = 0;
    NSInteger ftatt = 0;
    NSInteger ftmate = 0;
    NSInteger offreb = 0;
    NSInteger defreb = 0;
    NSInteger fouls = 0;
    NSInteger stl = 0;
    NSInteger blkagainst = 0;
    NSInteger blk = 0;
    for (HBMatchDetailsModel *dmodel in dataList) {
        pts += dmodel.pts.integerValue;
        ast += dmodel.ast.integerValue;
        reb += dmodel.reb.integerValue;
        fgatt += dmodel.fgatt.integerValue;
        fgmate += dmodel.fgmade.integerValue;
        fg3att += dmodel.fg3ptatt.integerValue;
        fg3mate += dmodel.fg3ptmade.integerValue;
        ftatt += dmodel.ftatt.integerValue;
        ftmate += dmodel.ftmade.integerValue;
        offreb += dmodel.offreb.integerValue;
        defreb += dmodel.defreb.integerValue;
        fouls += dmodel.fouls.integerValue;
        stl += dmodel.stl.integerValue;
        blkagainst += dmodel.blkagainst.integerValue;
        blk += dmodel.blk.integerValue;
    }
    [self.counts addObject:[NSString stringWithFormat:@"%ld", pts]];
    [self.counts addObject:[NSString stringWithFormat:@"%ld", ast]];
    [self.counts addObject:[NSString stringWithFormat:@"%ld", reb]];
    [self.counts addObject:[NSString stringWithFormat:@"%ld - %ld", fgmate, fgatt]];
    [self.counts addObject:[NSString stringWithFormat:@"%ld - %ld", fg3mate, fg3att]];
    [self.counts addObject:[NSString stringWithFormat:@"%ld - %ld", ftmate, ftatt]];
    [self.counts addObject:[NSString stringWithFormat:@"%ld", offreb]];
    [self.counts addObject:[NSString stringWithFormat:@"%ld", defreb]];
    [self.counts addObject:[NSString stringWithFormat:@"%ld", fouls]];
    [self.counts addObject:[NSString stringWithFormat:@"%ld", stl]];
    [self.counts addObject:[NSString stringWithFormat:@"%ld", blkagainst]];
    [self.counts addObject:[NSString stringWithFormat:@"%ld", blk]];
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HBMatchDetailsModel *model = self.dataList[indexPath.row];
    if (tableView == self.leftTableView) {
        HBMatchDataLeftCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HBMatchDataLeftCell class])];
        [cell refreshWithName:model.name row:indexPath.row];
        return cell;
    }
    HBMatchDataRightCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HBMatchDataRightCell class])];
    [cell refreshWithModel:model row:indexPath.row];
    return cell;
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (self.dataList.count == 0) {
        return 0;
    }
    return 30;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (self.dataList.count == 0) {
        return nil;
    }
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.jx_width, 30)];
    view.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"f4f7f0"];
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 29, tableView.jx_width, 1)];
    line.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"dddddd"];
    [view addSubview:line];
    if (tableView == self.leftTableView) {
        [self addLabelToView:view withFrame:view.bounds text:@"球員"];
    } else {
        NSArray *titles = @[@"位置", @"時間", @"得分", @"助攻",
                            @"籃板", @"投籃", @"3分", @"罰球",
                            @"前場", @"後場", @"犯規", @"搶斷",
                            @"失誤", @"封蓋", @"+/-"];
        for (NSInteger i=0; i<15; i++) {
            [self addLabelToView:view withFrame:CGRectMake(i*70, 0, 70, 30) text:titles[i]];
        }
    }
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (self.dataList.count == 0) {
        return 0;
    }
    return 30;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (self.dataList.count == 0) {
        return nil;
    }
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.jx_width, 30)];
    view.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"f4f7f0"];
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.jx_width, 1)];
    line.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"dddddd"];
    [view addSubview:line];
    if (tableView == self.rightTableView) {
        for (NSInteger i=2; i<14; i++) {
            [self addLabelToView:view withFrame:CGRectMake(i*70, 0, 70, 30) text:self.counts[i-2]];
        }
        for (NSInteger i=1; i<15; i++) {
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(70*i, 0, 1, 30)];
            line.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"dddddd"];
            [view addSubview:line];
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
