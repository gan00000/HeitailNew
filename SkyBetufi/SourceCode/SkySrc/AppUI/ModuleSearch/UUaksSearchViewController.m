//
//  UUaksSearchViewController.m
//  SkyBallPlay
//
//  Created by ganyuanrong on 2020/8/31.
//  Copyright © 2020 Dean_F. All rights reserved.
//

#import "UUaksSearchViewController.h"
#import <Masonry.h>
#import "WSKggConfigCoreUtil.h"
#import "MMoogHTSearchHistoryTableViewCell.h"
#import "BlysaSearchRequest.h"
#import "WSKggSearchData.h"
#import "NSNiceHTNewsDetailViewController.h"

@interface UUaksSearchViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic,strong) UITextField *xSearchTextField;
//@property (nonatomic,strong) UIButton *xRightSearchButton;
@property (nonatomic,strong) UIView *mTitleView;
@property (nonatomic,strong) UIButton *xDeleteButton;
@property (nonatomic,strong) NSMutableArray *searchHistoryArray;
@property (weak, nonatomic) IBOutlet UITableView *historyTableView;

@property (weak, nonatomic) IBOutlet UITableView *searchContentTableView;
@property (nonatomic, strong) YeYeeBJError *error;
@property (nonatomic, assign) BOOL newsRequestDone;
@property (nonatomic, strong) NSArray *newsList;
@property (nonatomic,strong) BlysaSearchRequest *xSearchRequest;
@property (nonatomic, strong) WSKggSearchData *xSearchData;

@end

@implementation UUaksSearchViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupViews];
    self.xSearchRequest = [[BlysaSearchRequest alloc] init];
    [self setupContentTableView];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

+ (instancetype)taoviewController {
    return kLoadStoryboardWithName(@"UKRosRedTHSearch");
}

#pragma mark - UI refresh
- (void)setupViews {
    self.view.backgroundColor = [UIColor whiteColor];
   // self.title = @"搜索";
    
    self.mTitleView = [[UIView alloc] initWithFrame:(CGRectMake(0, 0, SCREEN_WIDTH * 0.6, 36))];
    self.mTitleView.backgroundColor = [UIColor whiteColor];
    self.mTitleView .layer.cornerRadius = 8;
    [self.mTitleView addSubview:self.xSearchTextField];
    [self.mTitleView addSubview:self.xDeleteButton];

    self.navigationItem.titleView = self.mTitleView;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"搜索"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(startSeatchAction)];

    [self.historyTableView registerNib:[UINib nibWithNibName:@"MMoogHTSearchHistoryTableViewCell" bundle:nil]
            forCellReuseIdentifier:@"MMoogHTSearchHistoryTableViewCell"];
    
    self.historyTableView.dataSource = self;
    self.historyTableView.delegate = self;
    self.historyTableView.tableFooterView = [[UIView alloc] init];
    self.historyTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.historyTableView.estimatedRowHeight = 0;
    self.historyTableView.estimatedSectionFooterHeight = 0;
    self.historyTableView.estimatedSectionHeaderHeight = 0;
    if (@available(iOS 11.0, *)) {
           self.historyTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
       } else {
           self.automaticallyAdjustsScrollViewInsets = NO;
       }
    
    self.xDeleteButton.hidden = YES;
    NSArray<NSNiceAccountModel *> *historiesSearch = [[WSKggConfigCoreUtil share] getAccountModels];
    self.searchHistoryArray = [[NSMutableArray alloc] initWithArray:historiesSearch];
    if (self.searchHistoryArray && self.searchHistoryArray.count > 0) {
        [self historyViewHidden:NO];
        [self.historyTableView reloadData];
    }else{
        [self historyViewHidden:YES];
    }
    
}

- (void)setupContentTableView {
   
    self.xSearchData = [[WSKggSearchData alloc] init];
    self.searchContentTableView.delegate = self.xSearchData;
    self.searchContentTableView.dataSource = self.xSearchData;
    self.searchContentTableView.tableFooterView = [[UIView alloc] init];
    self.searchContentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.searchContentTableView.estimatedRowHeight = 0;
    self.searchContentTableView.estimatedSectionFooterHeight = 0;
    self.searchContentTableView.estimatedSectionHeaderHeight = 0;
    [self.searchContentTableView registerNib:[UINib nibWithNibName:@"KSasxHTNewsHomeCell" bundle:nil]
         forCellReuseIdentifier:@"KSasxHTNewsHomeCell"];
    kWeakSelf
//    self.searchContentTableView.mj_header = [BlysaMJRefreshGenerator bj_headerWithRefreshingBlock:^{
//        weakSelf.searchContentTableView.mj_footer.hidden = YES;
//        [weakSelf loadData:@""];
//    }];
    self.searchContentTableView.mj_footer = [BlysaMJRefreshGenerator bj_foorterWithRefreshingBlock:^{
        weakSelf.searchContentTableView.mj_header.hidden = YES;
        [weakSelf loadNextPage];
    }];
    if (@available(iOS 11.0, *)) {
        self.searchContentTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
   
    self.xSearchData.xClickHander = ^(NSInteger i) {
        NSNiceHTNewsDetailViewController *detailVc = [NSNiceHTNewsDetailViewController taoviewController];
        UUaksHTNewsModel *newsModel = self.newsList[i];
           detailVc.post_id = newsModel.news_id;
        [self.navigationController pushViewController:detailVc animated:YES];
    };
}

- (void)refreshUI {
    if (!self.newsRequestDone) {
        return;
    }
//    [self.view hideLoadingView];
//    [self.view hideEmptyView];
    [self.searchContentTableView.mj_header endRefreshing];
    if (self.xSearchRequest.hasMore) {
        [self.searchContentTableView.mj_footer endRefreshing];
    } else {
        [self.searchContentTableView.mj_footer endRefreshingWithNoMoreData];
    }
    if (self.error) {
        if (!self.newsList) {
            kWeakSelf
            [self.view showEmptyViewWithTitle:@"獲取失敗，點擊重試" tapBlock:^{
                [weakSelf.view hideEmptyView];
                [weakSelf.view showLoadingView];
//                [weakSelf loadData];
            }];
        } else {
            [self.view showToast:self.error.msg];
        }
        self.error = nil;
    }
   
    [self historyViewHidden:YES];
    self.xSearchData.newsList = self.newsList;
   
    [self.searchContentTableView reloadData];
}

-(void) historyViewHidden:(BOOL)hidden
{
    self.historyTableView.hidden = hidden;
    self.searchContentTableView.hidden = !hidden;
   
}

- (void)loadData:(NSString *)key {
    self.newsRequestDone = NO;
    kWeakSelf
    [self.xSearchRequest requestWithKey:key successBlock:^(NSArray<UUaksHTNewsModel *> *newsList) {
        weakSelf.newsList = newsList;
        weakSelf.newsRequestDone = YES;
        
        [[WSKggConfigCoreUtil share]saveAccount:key password:@"1" updateTime:YES];
        [self refreshHistoryData];
        NSArray<NSNiceAccountModel *> *historiesSearch = [[WSKggConfigCoreUtil share] getAccountModels];
           //self.searchHistoryArray = [[NSMutableArray alloc] initWithArray:historiesSearch];
           if (historiesSearch && historiesSearch.count > 0) {
        
               [self.searchHistoryArray removeAllObjects];
               [self.searchHistoryArray addObjectsFromArray:historiesSearch];
               [self.historyTableView reloadData];
        }
        [weakSelf refreshUI];
        
    } errorBlock:^(YeYeeBJError *error) {
        weakSelf.error = error;
        weakSelf.newsRequestDone = YES;
        [weakSelf refreshUI];
    }];

}
- (void)loadNextPage {
    self.newsRequestDone = NO;
    kWeakSelf
    [self.xSearchRequest loadNextPageWithSuccessBlock:^(NSArray<UUaksHTNewsModel *> *newsList) {
        weakSelf.newsList = newsList;
        weakSelf.newsRequestDone = YES;
        [weakSelf refreshUI];
     } errorBlock:^(YeYeeBJError *error) {
         weakSelf.newsRequestDone = YES;
         [weakSelf refreshUI];
     }];
}

//icon_delete

- (UIButton *)xDeleteButton {
    if (!_xDeleteButton) {
        _xDeleteButton = [[UIButton alloc] initWithFrame:CGRectMake(self.mTitleView.width - 34, (self.mTitleView.height - 20) / 2, 18, 18)];
        _xDeleteButton.clipsToBounds = YES;
        //_xDeleteButton.layer.cornerRadius = 18;
        [_xDeleteButton setImage:[UIImage imageNamed:@"icon_delete"] forState:(UIControlStateNormal)];
        [_xDeleteButton addTarget:self action:@selector(deleteAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _xDeleteButton;
}

//- (UIButton *)xRightSearchButton {
//    if (!_xRightSearchButton) {
//        _xRightSearchButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, self.mTitleView.height)];
////        _xRightSearchButton.clipsToBounds = YES;
//        //_xRightSearchButton.layer.cornerRadius = 18;
//        _xRightSearchButton.titleLabel.textColor = [UIColor whiteColor];
//        _xRightSearchButton.titleLabel.text = @"搜索";
//        [_xRightSearchButton addTarget:self action:@selector(startSeatchAction) forControlEvents:UIControlEventTouchUpInside];
//    }
//    return _xRightSearchButton;
//}

-(UITextField *)xSearchTextField{
    if (!_xSearchTextField) {
        _xSearchTextField = [[UITextField alloc] initWithFrame:(CGRectMake(6, 0, self.mTitleView.width - 12, self.mTitleView.height))];
        _xSearchTextField.backgroundColor = [UIColor clearColor];
//        _xSearchTextField.layer.cornerRadius = 8;
        _xSearchTextField.textColor = [UIColor blackColor];
        _xSearchTextField.textAlignment = NSTextAlignmentLeft;
        _xSearchTextField.placeholder = @"輸入你感興趣的內容";
        _xSearchTextField.tintColor = [UIColor blackColor];//光标颜色
        [_xSearchTextField addTarget:self action:@selector(textFieldTextChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _xSearchTextField;
}

- (void)refreshHistoryData {
    NSArray<NSNiceAccountModel *> *historiesSearch = [[WSKggConfigCoreUtil share] getAccountModels];
    //self.searchHistoryArray = [[NSMutableArray alloc] initWithArray:historiesSearch];
    if (historiesSearch && historiesSearch.count > 0) {
        
        [self.searchHistoryArray removeAllObjects];
        [self.searchHistoryArray addObjectsFromArray:historiesSearch];
        [self historyViewHidden:NO];
        [self.historyTableView reloadData];
    }else{
       [self historyViewHidden:YES];
    }
}

-(void)textFieldTextChange:(UITextField *)textField{
    NSLog(@"textField1 - 输入框内容改变,当前内容为: %@",textField.text);
    if (textField.text.length > 0) {
         self.xDeleteButton.hidden = NO;
    }else{
        self.xDeleteButton.hidden = YES;
        [self refreshHistoryData];
    }
}

#pragma mark - ui action
- (void)startSeatchAction {
    NSString *text = self.xSearchTextField.text;
    if (text) {
        [self loadData:text];
    }
}

- (void)deleteAction {
    self.xSearchTextField.text = @"";
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  
    return self.searchHistoryArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"indexPath.section:%ld  indexPath.row:%ld", indexPath.section, indexPath.row);
    NSNiceAccountModel *data = self.searchHistoryArray[indexPath.row];
    
    MMoogHTSearchHistoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MMoogHTSearchHistoryTableViewCell"];
    [cell setHistory:data.accountName];
    cell.mClickHander = ^(NSInteger i) {
        [[WSKggConfigCoreUtil share] removeAccount:data.accountName];
        [self refreshHistoryData];
    };
    return cell;
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    return 40;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSNiceAccountModel *data = self.searchHistoryArray[indexPath.row];
    self.xSearchTextField.text = data.accountName;
    [self startSeatchAction];
}

@end
