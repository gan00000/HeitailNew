#import <UIKit/UIKit.h>
typedef void(^JXScrollStopBlock)(void);
@interface UIScrollView (JXScrollStop)
@property (nonatomic, assign) BOOL jx_needHook;
@property (nonatomic, copy) JXScrollStopBlock jx_scrollStopBlock;
@end
