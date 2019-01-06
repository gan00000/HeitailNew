#import <UIKit/UIKit.h>
@interface JXTextView : UITextView
@property (nonatomic) IBInspectable BOOL masksToBounds;
@property (nonatomic) IBInspectable CGFloat cornerRadius;
@property (nonatomic, copy) IBInspectable NSString *placeholder;
@property (nonatomic, strong) IBInspectable UIColor *placeholderColor;
@end
