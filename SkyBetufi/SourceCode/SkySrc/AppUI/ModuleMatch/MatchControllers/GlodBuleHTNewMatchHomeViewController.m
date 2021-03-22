//
//  XXXHeiTai
//
//  Created by ganyuanrong on 2021/3/15.
//  Copyright © 2021 Dean_F. All rights reserved.
//

#import "GlodBuleHTNewMatchHomeViewController.h"
#import "GlodBuleHTMatchHomeViewController.h"
#import "GlodBuleHTMatchHomeRequest.h"

@interface GlodBuleHTNewMatchHomeViewController () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *contenView;

@property (nonatomic, strong) HMSegmentedControl *segmentControl;
@property (nonatomic, strong) UIScrollView *containerView;
@property (nonatomic, strong) NSMutableArray *loadedControllersArray;
@property (nonatomic, strong) NSMutableArray *loadedFlagArray;
@property (nonatomic, assign) NSInteger currentIndex;

@property (nonatomic, strong) NSMutableArray *titlesArray;
@property (nonatomic, strong) NSMutableArray *titlesArrayValue;

@end

@implementation GlodBuleHTNewMatchHomeViewController


+ (instancetype)taoviewController {
    return kLoadStoryboardWithName(@"GlodBuleHTNewMatchHomeViewController");
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"比賽";
    
    self.titlesArray = [NSMutableArray array];
    self.titlesArrayValue = [NSMutableArray array];
    [self loadData];
}

- (void)setupUI
{
   
//    self.titlesArray = @[@"xx",@"xxxa"];
    for (NSInteger i = 0; i < self.titlesArray.count; i++) {
        [self.loadedFlagArray addObject:@(NO)];
        [self.loadedControllersArray addObject:@(NO)];
    }
    
    [self.contenView addSubview:self.segmentControl];
    [self.segmentControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_offset(0);
        make.height.mas_equalTo(40);
    }];
    [self.contenView addSubview:self.containerView];
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_offset(0);
        make.top.mas_equalTo(self.segmentControl.mas_bottom).mas_offset(1);
    }];
    [self segmentedValueChangedHandle:0];
}

-(void)loadData
{
    [self.view showLoadingView];
    [GlodBuleHTMatchHomeRequest get_league_list_successBlock:^(NSDictionary *leagueList) {
        
        [self.view hideLoadingView];
        
        for (NSString *key in leagueList) {
            //处理字典的键值
            NSString *value = [NSString stringWithFormat:@"%@", leagueList[key]];
//            NSUInteger xxx = leagueList[key];
//            NSNumber *longNumber = [NSNumber numberWithLong: xxx];
//            NSString *longStr = [longNumber stringValue];
            
            [self.titlesArray addObject:key];
            [self.titlesArrayValue addObject: value];
        }
        
        [self setupUI];
        
    } errorBlock:^(GlodBuleBJError *error) {
        [self.view hideLoadingView];
        kWeakSelf
        [self.contenView showEmptyViewWithTitle:@"獲取失敗，點擊重試" tapBlock:^{
            [weakSelf loadData];
            [weakSelf.contenView hideEmptyView];
        }];
    }];
}

#pragma mark - BJNavigationDelegate
//- (void)tao_handleNavBack{
//    [self viewWillDisappear:YES];
//}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGPoint offset = scrollView.contentOffset;
    NSInteger page = offset.x / SCREEN_WIDTH;
    self.currentIndex = page;
    [self loadChildViewControllerByIndex:page];
    [self.segmentControl setSelectedSegmentIndex:page animated:YES];
}


#pragma mark -- HMSegmentedControl Action
- (void)segmentedValueChangedHandle:(NSInteger)index {
    self.currentIndex = index;
    [self loadChildViewControllerByIndex:index];
    [self.containerView setContentOffset:CGPointMake(index * SCREEN_WIDTH, 0) animated:YES];
}

- (void)loadChildViewControllerByIndex:(NSInteger)index {
    
    if ([self.loadedFlagArray[index] boolValue]) {
        if (index == 0) {

            GlodBuleHTMatchHomeViewController *vc = self.loadedControllersArray[index];
            
        } else if (index == 1) {
      
            GlodBuleHTMatchHomeViewController *vc = self.loadedControllersArray[index];
        }
        return;
    }
    kWeakSelf
    UIViewController *vc;
    if (index == 0) {
        
        GlodBuleHTMatchHomeViewController *mhVc = [GlodBuleHTMatchHomeViewController taoviewController];
        mhVc.matchType = self.titlesArrayValue[index];
        vc = mhVc;

    } else if (index == 1) {
        GlodBuleHTMatchHomeViewController *mhVc = [GlodBuleHTMatchHomeViewController taoviewController];
        mhVc.matchType = self.titlesArrayValue[index];
        vc = mhVc;
    }
    [self addChildViewController:vc];
    [self.containerView addSubview:vc.view];
    [self.loadedFlagArray replaceObjectAtIndex:index withObject:@(YES)];
    [self.loadedControllersArray replaceObjectAtIndex:index withObject:vc];
    [self setChildViewFrame:vc.view byIndex:index];
    
//         [weakSelf loadData];
    
}
- (void)setChildViewFrame:(UIView *)childView byIndex:(NSInteger)index {
    [childView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.containerView);
        make.width.equalTo(self.containerView);
        make.height.equalTo(self.containerView);
        make.left.equalTo(self.containerView).offset(index * SCREEN_WIDTH);
    }];
}

#pragma mark -- lazy load
- (NSMutableArray *)loadedFlagArray {
    if (!_loadedFlagArray) {
        _loadedFlagArray = [NSMutableArray array];
    }
    return _loadedFlagArray;
}
- (NSMutableArray *)loadedControllersArray {
    if (!_loadedControllersArray) {
        _loadedControllersArray = [NSMutableArray array];
    }
    return _loadedControllersArray;
}

- (HMSegmentedControl *)segmentControl {
    if (!_segmentControl) {

        _segmentControl = [[HMSegmentedControl alloc] initWithSectionTitles:self.titlesArray];
        _segmentControl.selectionIndicatorColor = [UIColor hx_colorWithHexRGBAString:@"fc562e"];
        _segmentControl.selectionIndicatorHeight = 3.0f;
        _segmentControl.selectionIndicatorEdgeInsets = UIEdgeInsetsMake(0, -8, 0, -18);
        _segmentControl.titleTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:15 weight:UIFontWeightMedium],NSForegroundColorAttributeName:[UIColor hx_colorWithHexRGBAString:@"666666"]};
        _segmentControl.selectedTitleTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:15 weight:UIFontWeightMedium],NSForegroundColorAttributeName:[UIColor hx_colorWithHexRGBAString:@"fc562e"]};
        _segmentControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
        _segmentControl.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
        kWeakSelf
        _segmentControl.indexChangeBlock = ^(NSUInteger index){
            [weakSelf segmentedValueChangedHandle:index];
        };
    }
    return _segmentControl;
}
- (UIScrollView *)containerView {
    if (!_containerView) {
        _containerView = [[UIScrollView alloc] init];
        _containerView.showsVerticalScrollIndicator = NO;
        _containerView.showsHorizontalScrollIndicator = NO;
        _containerView.delegate = self;
        _containerView.pagingEnabled = YES;
        _containerView.autoresizingMask = UIViewAutoresizingNone;
        _containerView.contentSize = CGSizeMake(SCREEN_WIDTH * self.titlesArray.count, SCREEN_HEIGHT - 64 - SCREEN_HEIGHT - 1);
        _containerView.bounces = NO;
    }
    return _containerView;
}
@end
