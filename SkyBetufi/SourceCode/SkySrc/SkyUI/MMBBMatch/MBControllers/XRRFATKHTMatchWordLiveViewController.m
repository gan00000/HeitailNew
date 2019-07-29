//
//  XRRFATKHTMatchWordLiveViewController.m
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/9/9.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import "XRRFATKHTMatchWordLiveViewController.h"
#import "XRRFATKHTMatchLiveFeedCell.h"

@interface XRRFATKHTMatchWordLiveViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, weak) NSArray<XRRFATKHTMatchLiveFeedModel *> *liveFeedList;

@end

@implementation XRRFATKHTMatchWordLiveViewController

+ (instancetype)skargviewController {
    return kLoadStoryboardWithName(@"XRRFATKMatchWordLive");
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

- (void)skargrefreshWithLiveFeedList:(NSArray<XRRFATKHTMatchLiveFeedModel *> *)liveFeedList {
    [self.tableView.mj_header endRefreshing];
    self.liveFeedList = liveFeedList;
    [self.tableView reloadData];
}

- (void)setupViews {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedRowHeight = 40;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XRRFATKHTMatchLiveFeedCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([XRRFATKHTMatchLiveFeedCell class])];
    
    kWeakSelf
    self.tableView.mj_header = [XRRFATKMJRefreshGenerator bj_headerWithRefreshingBlock:^{
        if (weakSelf.onTableHeaderRefreshBlock) {
            weakSelf.onTableHeaderRefreshBlock();
        }
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.liveFeedList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XRRFATKHTMatchLiveFeedCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([XRRFATKHTMatchLiveFeedCell class])];
    [cell skargsetupWithMatchLiveFeedModel:self.liveFeedList[indexPath.row]];
    return cell;
}

@end
