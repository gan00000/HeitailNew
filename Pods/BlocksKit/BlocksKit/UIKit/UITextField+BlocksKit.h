#import <UIKit/UITextField.h>
#import "BlocksKit.h"
@interface UITextField (BlocksKit)
@property (nonatomic, copy) BOOL(^bk_shouldBeginEditingBlock)(UITextField *);
@property (nonatomic, copy) void(^bk_didBeginEditingBlock)(UITextField *);
@property (nonatomic, copy) BOOL(^bk_shouldEndEditingBlock)(UITextField *);
@property (nonatomic, copy) void(^bk_didEndEditingBlock)(UITextField *);
@property (nonatomic, copy) BOOL(^bk_shouldChangeCharactersInRangeWithReplacementStringBlock)(UITextField *, NSRange, NSString *);
@property (nonatomic, copy) BOOL(^bk_shouldClearBlock)(UITextField *);
@property (nonatomic, copy) BOOL(^bk_shouldReturnBlock)(UITextField *);
@end
