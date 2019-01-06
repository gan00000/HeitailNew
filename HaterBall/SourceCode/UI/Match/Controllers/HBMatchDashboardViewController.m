#import "HBMatchDashboardViewController.h"
#import "HBMatchSubDsbdViewController.h"
#import <HMSegmentedControl/HMSegmentedControl.h>
@interface HBMatchDashboardViewController () <UIScrollViewDelegate>
@property (nonatomic, strong) HMSegmentedControl *segmentControl;
@property (nonatomic, strong) UIScrollView *containerView;
@property (nonatomic, strong) NSMutableArray *loadedControllersArray;
@property (nonatomic, strong) NSMutableArray *loadedFlagArray;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, weak) HBMatchCompareModel *compareModel;
@end
@implementation HBMatchDashboardViewController
+ (instancetype)viewController {
    return kLoadStoryboardWithName(@"MatchDashboard");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self setupUI];
}
#pragma mark - private
- (void)initData {
    self.currentIndex = 0;
    for (NSInteger i = 0; i < 2; i++) {
        [self.loadedFlagArray addObject:@(NO)];
        [self.loadedControllersArray addObject:@(NO)];
    }
}
- (void)setupUI {
    self.title = @"數據";
    [self.view addSubview:self.segmentControl];
    [self.segmentControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_offset(0);
        make.height.mas_equalTo(40);
    }];
    [self.view addSubview:self.containerView];
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_offset(0);
        make.top.mas_equalTo(self.segmentControl.mas_bottom);
    }];
    [self segmentedValueChangedHandle:0];
}
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
        HBMatchSubDsbdViewController *vc = self.loadedControllersArray[index];
        if (index == 0) {
            [vc refreshWithDetailList:self.compareModel.awayTeamDetails];
        } else if (index == 1) {
            [vc refreshWithDetailList:self.compareModel.homeTeamDetails];
        }
        return;
    }
    HBMatchSubDsbdViewController *vc = [HBMatchSubDsbdViewController viewController];
    if (index == 0) {
        [vc refreshWithDetailList:self.compareModel.awayTeamDetails];
    } else if (index == 1) {
        [vc refreshWithDetailList:self.compareModel.homeTeamDetails];
    }
    [self addChildViewController:vc];
    [self.containerView addSubview:vc.view];
    [self.loadedFlagArray replaceObjectAtIndex:index withObject:@(YES)];
    [self.loadedControllersArray replaceObjectAtIndex:index withObject:vc];
    [self setChildViewFrame:vc.view byIndex:index];
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
        _segmentControl = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"客隊", @"主隊"]];
        _segmentControl.selectionIndicatorColor = [UIColor blueColor];
        _segmentControl.selectionIndicatorHeight = 3.0f;
        _segmentControl.selectionIndicatorEdgeInsets = UIEdgeInsetsMake(0, -8, 0, -18);
        _segmentControl.titleTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:15 weight:UIFontWeightMedium],NSForegroundColorAttributeName:[UIColor hx_colorWithHexRGBAString:@"666666"]};
        _segmentControl.selectedTitleTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:15 weight:UIFontWeightMedium],NSForegroundColorAttributeName:[UIColor blueColor]};
        _segmentControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
        _segmentControl.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
        kWeakSelf
        _segmentControl.indexChangeBlock = ^(NSInteger index){
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
        _containerView.contentSize = CGSizeMake(SCREEN_WIDTH * 2, SCREEN_HEIGHT - 64 - SCREEN_HEIGHT - 1);
        _containerView.bounces = NO;
    }
    return _containerView;
}
- (void)dealloc {
    BJLog(@"\n---- %@ is dealloc!!\n-",[self class]);
}
- (void)refreshWithMatchCompareModel:(HBMatchCompareModel *)compareModel {
    self.compareModel = compareModel;
    if (_segmentControl) {
        [self segmentedValueChangedHandle:self.currentIndex];
    }
}
@end
