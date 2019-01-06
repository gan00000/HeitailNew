#import "UIScrollView+JXScrollStop.h"
#import <objc/runtime.h>
static void *kJXScrollStopNeedHookKey;
static void *kJXScrollStopBlockKey;
@implementation UIScrollView (JXScrollStop)
+ (void)load {
    [super load];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method originalMethod = class_getInstanceMethod([UIScrollView class], @selector(setDelegate:));
        Method replaceMethod = class_getInstanceMethod([UIScrollView class], @selector(jx_hook_setDelegate:));
        method_exchangeImplementations(originalMethod, replaceMethod);
    });
}
- (void)jx_hook_setDelegate:(id<UIScrollViewDelegate>)delegate {
    [self jx_hook_setDelegate:delegate];
    if (self.jx_needHook && ([self isMemberOfClass:[UIScrollView class]] || [self isKindOfClass:[UITableView class]] || [self isKindOfClass:[UICollectionView class]])) {
        JXHookMethod([delegate class], @selector(scrollViewDidEndDecelerating:), [self class], @selector(jx_scrollViewDidEndDecelerating:), @selector(jx_add_scrollViewDidEndDecelerating:));
        JXHookMethod([delegate class], @selector(scrollViewDidEndDragging:willDecelerate:), [self class], @selector(jx_scrollViewDidEndDragging:willDecelerate:), @selector(jx_add_scrollViewDidEndDragging:willDecelerate:));
        JXHookMethod([delegate class], @selector(scrollViewDidEndScrollingAnimation:), [self class], @selector(jx_scrollViewDidEndScrollingAnimation:), @selector(jx_add_scrollViewDidEndScrollingAnimation:));
    } else {
    }
}
#pragma mark - Replace Method
- (void)jx_scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self jx_scrollViewDidEndDecelerating:scrollView];
    BOOL scrollToScrollStop = !scrollView.tracking && !scrollView.dragging && !scrollView.decelerating;
    if (scrollToScrollStop) {
        [scrollView jx_scrollStop:scrollView];
    }
}
- (void)jx_scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self jx_scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
    if (!decelerate) {
        BOOL dragToDragStop = scrollView.tracking && !scrollView.dragging && !scrollView.decelerating;
        if (dragToDragStop) {
            [scrollView jx_scrollStop:scrollView];
        }
    }
}
- (void)jx_scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [self jx_scrollViewDidEndScrollingAnimation:scrollView];
    BOOL scrollToScrollStop = !scrollView.tracking && !scrollView.dragging && !scrollView.decelerating;
    if (scrollToScrollStop) {
        [scrollView jx_scrollStop:scrollView];
    }
}
#pragma mark - Add Method
- (void)jx_add_scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    BOOL scrollToScrollStop = !scrollView.tracking && !scrollView.dragging && !scrollView.decelerating;
    if (scrollToScrollStop) {
        [scrollView jx_scrollStop:scrollView];
    }
}
- (void)jx_add_scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        BOOL dragToDragStop = scrollView.tracking && !scrollView.dragging && !scrollView.decelerating;
        if (dragToDragStop) {
            [scrollView jx_scrollStop:scrollView];
        }
    }
}
- (void)jx_add_scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    BOOL scrollToScrollStop = !scrollView.tracking && !scrollView.dragging && !scrollView.decelerating;
    if (scrollToScrollStop) {
        [scrollView jx_scrollStop:scrollView];
    }
}
#pragma mark - Private Method
static void JXHookMethod(Class originalClass, SEL originalSel, Class replacedClass, SEL replacedSel, SEL noneSel) {
    Method originalMethod = class_getInstanceMethod(originalClass, originalSel);
    Method replaceMethod = class_getInstanceMethod(replacedClass, replacedSel);
    if (!originalMethod) {
        Method noneMethod = class_getInstanceMethod(replacedClass, noneSel);
        BOOL addNoneMethod = class_addMethod(originalClass, originalSel, method_getImplementation(noneMethod), method_getTypeEncoding(noneMethod));
        if (addNoneMethod) {
        }
        return;
    }
    BOOL addMethod = class_addMethod(originalClass, replacedSel, method_getImplementation(replaceMethod), method_getTypeEncoding(replaceMethod));
    if (addMethod) {
        Method newMethod = class_getInstanceMethod(originalClass, replacedSel);
        method_exchangeImplementations(originalMethod, newMethod);
    } else {
    }
}
- (void)jx_scrollStop:(UIScrollView *)scrollView {
    self.jx_scrollStopBlock ? self.jx_scrollStopBlock() : nil;
}
#pragma mark - Property Method
- (BOOL)jx_needHook {
    return [objc_getAssociatedObject(self, &kJXScrollStopNeedHookKey) boolValue];
}
- (void)setJx_needHook:(BOOL)jx_needHook {
    objc_setAssociatedObject(self, &kJXScrollStopNeedHookKey, [NSNumber numberWithBool:jx_needHook], OBJC_ASSOCIATION_ASSIGN);
}
- (JXScrollStopBlock)jx_scrollStopBlock {
    return objc_getAssociatedObject(self, &kJXScrollStopBlockKey);
}
- (void)setJx_scrollStopBlock:(JXScrollStopBlock)jx_scrollStopBlock {
    objc_setAssociatedObject(self, &kJXScrollStopBlockKey, jx_scrollStopBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
@end
