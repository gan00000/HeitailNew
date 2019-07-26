//
//  XRRFATKHTMatchCompareViewController.m
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/9/9.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import "XRRFATKHTMatchCompareViewController.h"
#import "XRRFATKHTMatchQuarterCell.h"
#import "XRRFATKHTMatchPtsCompareCell.h"
#import "XRRFATKHTMatchBestPlayerCell.h"

@interface XRRFATKHTMatchCompareViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, weak) XRRFATKHTMatchSummaryModel *summaryModel;

@end

@implementation XRRFATKHTMatchCompareViewController

+ (instancetype)viewController {
    return kLoadStoryboardWithName(@"XRRFATKMatchCompare");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupViews];
}

- (void)dealloc {
    NSLog(@"%@ dealloc", NSStringFromClass(self.class));
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)refreshWithMatchSummaryModel:(XRRFATKHTMatchSummaryModel *)summaryModel {
    [self.tableView.mj_header endRefreshing];
    self.summaryModel = summaryModel;
    [self.tableView reloadData];
}

- (void)setupViews {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 40;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XRRFATKHTMatchQuarterCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([XRRFATKHTMatchQuarterCell class])];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XRRFATKHTMatchPtsCompareCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([XRRFATKHTMatchPtsCompareCell class])];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XRRFATKHTMatchBestPlayerCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([XRRFATKHTMatchBestPlayerCell class])];
    
    kWeakSelf
    self.tableView.mj_header = [XRRFATKMJRefreshGenerator bj_headerWithRefreshingBlock:^{
        if (weakSelf.onTableHeaderRefreshBlock) {
            weakSelf.onTableHeaderRefreshBlock();
        }
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        XRRFATKHTMatchQuarterCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([XRRFATKHTMatchQuarterCell class])];
        [cell setupWithMatchSummaryModel:self.summaryModel];
        return cell;
    }
    if (indexPath.section == 1) {
        XRRFATKHTMatchPtsCompareCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([XRRFATKHTMatchPtsCompareCell class])];
        [cell setupWithMatchSummaryModel:self.summaryModel];
        return cell;
    }
    XRRFATKHTMatchBestPlayerCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([XRRFATKHTMatchBestPlayerCell class])];
    [cell setupWithMatchSummaryModel:self.summaryModel];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 105;
    }
    if (indexPath.section == 1) {
        return 320;
    }
    return 260;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section > 0) {
        return 10;
    }
    return 0.0001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0001;
}

@end
