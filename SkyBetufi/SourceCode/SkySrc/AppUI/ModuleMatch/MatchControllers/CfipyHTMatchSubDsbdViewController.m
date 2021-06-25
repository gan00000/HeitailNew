#import "CfipyHTMatchSubDsbdViewController.h"
#import "CfipyHTMatchDataLeftCell.h"
#import "KSasxHTMatchDataRightCell.h"
#import "MMoogPlayerInfoViewController.h"

@interface CfipyHTMatchSubDsbdViewController ()<UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *leftTableView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollContentView;
@property (nonatomic, strong) UITableView *rightTableView;
@property (nonatomic) NSMutableArray<UUaksHTMatchDetailsModel *> *dataList;

@property (nonatomic) NSArray<UUaksHTMatchDetailsModel *> *tempDetailList;

@property (nonatomic, strong) NSMutableArray *counts;//总计
//@property (nonatomic) NSInteger rightViewItemCount;

@property (nonatomic, assign) CGFloat c_width;
@end
@implementation CfipyHTMatchSubDsbdViewController
+ (instancetype)taoviewController {
    return kLoadStoryboardWithName(@"FaCaiMatchSubDsbd");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"dddddd"];
    
    self.dataList = [NSMutableArray array];
    
    [self setupLeftTableView];
//    [self setupRightTableView];

}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self setupRightTableView];
    [self taorefreshWithDetailList:self.tempDetailList];
}
- (void)setupLeftTableView {
    
    self.c_width = 50;
    
    self.leftTableView.delegate = self;
    self.leftTableView.dataSource = self;
    self.leftTableView.rowHeight = 30;
    self.leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    if (@available(iOS 11.0, *)) {
        self.leftTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self.leftTableView registerNib:[UINib nibWithNibName:NSStringFromClass([CfipyHTMatchDataLeftCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([CfipyHTMatchDataLeftCell class])];
}
- (void)setupRightTableView {
    [self.scrollContentView setContentSize:CGSizeMake(14 * 50, self.leftTableView.jx_height)];
    self.rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 14 * 50, self.leftTableView.jx_height) style:UITableViewStylePlain];
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
    [self.rightTableView registerNib:[UINib nibWithNibName:NSStringFromClass([KSasxHTMatchDataRightCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([KSasxHTMatchDataRightCell class])];
    [self.scrollContentView addSubview:self.rightTableView];
}
- (void)taorefreshWithDetailList:(NSArray<UUaksHTMatchDetailsModel *> *)detailList {
    
    self.tempDetailList = detailList;
    //分别对首发和替补按时间排序start
    NSMutableArray *firstPlayerArr = [NSMutableArray array];
    NSMutableArray *subPlayerArr = [NSMutableArray array];
    for (int i = 0; i < detailList.count; i++) {
        
        if (i < 5) {
            [firstPlayerArr addObject:detailList[i]];
        }else{
            [subPlayerArr addObject:detailList[i]];
        }
    }
    [firstPlayerArr sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        UUaksHTMatchDetailsModel *model1 = (UUaksHTMatchDetailsModel *)obj1;
        UUaksHTMatchDetailsModel *model2 = (UUaksHTMatchDetailsModel *)obj2;
        return model1.minseconds < model2.minseconds;
    }];
    
    [subPlayerArr sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        UUaksHTMatchDetailsModel *model1 = (UUaksHTMatchDetailsModel *)obj1;
        UUaksHTMatchDetailsModel *model2 = (UUaksHTMatchDetailsModel *)obj2;
        return model1.minseconds < model2.minseconds;
    }];
    
    //分别对首发和替补按时间排序end
    [self.dataList removeAllObjects];
    [self.dataList addObjectsFromArray:firstPlayerArr];
    [self.dataList addObjectsFromArray:subPlayerArr];
    
    [self countWithDataList:self.dataList];
    [self.leftTableView reloadData];
    [self.rightTableView reloadData];
}
- (void)addLabelToView:(UIView *)view withFrame:(CGRect)frame text:(NSString *)text {
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = text;
    label.textColor = [UIColor hx_colorWithHexRGBAString:@"111111"];
    label.font = [UIFont systemFontOfSize:14];
    label.textAlignment = NSTextAlignmentCenter;
    [view addSubview:label];
}
- (void)countWithDataList:(NSArray<UUaksHTMatchDetailsModel *> *)dataList { //计算总计
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
    for (UUaksHTMatchDetailsModel *dmodel in dataList) {
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
    
    NSMutableArray *ppDataList = [dataList mutableCopy];
    //添加一个命中率
    UUaksHTMatchDetailsModel *xxModel = [[UUaksHTMatchDetailsModel alloc] init];
    xxModel.name = @"命中率";
    xxModel.time = @"-";
    xxModel.pts = @"-";
    xxModel.ast = @"-";
    xxModel.reb = @"-";
    if (fgatt != 0) {
        xxModel.fgmade_show = [NSString stringWithFormat:@"%ld%%", fgmate * 100 / fgatt];
    }else{
        xxModel.fgmade_show = @"0%%";
    }
    if (fg3att == 0) {
        xxModel.fg3ptmade_show = @"0%%";
    } else {
        xxModel.fg3ptmade_show = [NSString stringWithFormat:@"%ld%%", fg3mate * 100 / fg3att];
    }
    if (ftatt == 0) {
        xxModel.ftmade_show = @"0%%";
    } else {
        xxModel.ftmade_show = [NSString stringWithFormat:@"%ld%%", ftmate * 100 / ftatt];
    }
    
    xxModel.offreb = @"-";
    xxModel.defreb = @"-";
    xxModel.fouls = @"-";
    xxModel.stl = @"-";
    xxModel.blkagainst = @"-";
    xxModel.blk = @"-";
    xxModel.plusminus = @"-";
    [ppDataList addObject:xxModel];
    self.dataList = [NSMutableArray arrayWithArray:ppDataList];
//    NSLog(@"dataList");
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UUaksHTMatchDetailsModel *model = self.dataList[indexPath.row];
    if (tableView == self.leftTableView) {
        CfipyHTMatchDataLeftCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CfipyHTMatchDataLeftCell class])];
        [cell taorefreshWithName:model.name row:indexPath.row];
        return cell;
    }
    KSasxHTMatchDataRightCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([KSasxHTMatchDataRightCell class])];
    [cell taorefreshWithModel:model row:indexPath.row];
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
    view.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"eef0f4"];
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 29, tableView.jx_width, 1)];
    line.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"dddddd"];
    [view addSubview:line];
    if (tableView == self.leftTableView) {
        [self addLabelToView:view withFrame:view.bounds text:@"球員"];
        //self.itemCount = self.itemCount + 1;
        
    } else {
        NSArray *titles = @[@"時間", @"得分", @"助攻",
                            @"籃板", @"投籃", @"3分", @"罰球",
                            @"前場", @"後場", @"犯規", @"抄截",
                            @"失誤", @"封蓋", @"+/-"];
        for (NSInteger i=0; i<titles.count; i++) {
            [self addLabelToView:view withFrame:CGRectMake(i*50, 0, 50, 30) text:titles[i]];
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
    view.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"ffffff"];
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.jx_width, 1)];
    line.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"dddddd"];
    [view addSubview:line];
    if (tableView == self.rightTableView) {
        for (NSInteger i=1; i< 13; i++) {
            [self addLabelToView:view withFrame:CGRectMake(i*self.c_width, 0, self.c_width, 30) text:self.counts[i-1]];
        }
        for (NSInteger i=1; i< 14; i++) { //画线
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(self.c_width*i, 0, 1, 30)];
            line.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"dddddd"];
            [view addSubview:line];
        }
    }
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.leftTableView) {
        UUaksHTMatchDetailsModel *model = self.dataList[indexPath.row];
        
        MMoogPlayerInfoViewController *piVc = [MMoogPlayerInfoViewController taoviewController];
        [piVc setData:model];
        [self.navigationController pushViewController:piVc animated:YES];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.leftTableView) {
        self.rightTableView.contentOffset = scrollView.contentOffset;
    } else {
        self.leftTableView.contentOffset = scrollView.contentOffset;
    }
}

@end
