#import "MJRefreshComponent.h"
@interface MJRefreshFooter : MJRefreshComponent
+ (instancetype)footerWithRefreshingBlock:(MJRefreshComponentRefreshingBlock)refreshingBlock;
+ (instancetype)footerWithRefreshingTarget:(id)target refreshingAction:(SEL)action;
- (void)endRefreshingWithNoMoreData;
- (void)noticeNoMoreData MJRefreshDeprecated("使用endRefreshingWithNoMoreData");
- (void)resetNoMoreData;
@property (assign, nonatomic) CGFloat ignoredScrollViewContentInsetBottom;
@property (assign, nonatomic, getter=isAutomaticallyHidden) BOOL automaticallyHidden MJRefreshDeprecated("不建议使用此属性，开发者请自行控制footer的显示和隐藏。基于安全考虑，在未来的某些版本此属性可能作废");
@end
