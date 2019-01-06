#import <UIKit/UIKit.h>
@protocol JXKeyInputTextFieldDelegate <NSObject>
- (void)textFieldDidDeleteBackward:(UITextField *)textField;
@end
@interface JXTextField : UITextField
@property (nonatomic) IBInspectable BOOL masksToBounds;
@property (nonatomic) IBInspectable CGFloat cornerRadius;
@property (nonatomic) IBInspectable CGFloat topInset;
@property (nonatomic) IBInspectable CGFloat leftInset;
@property (nonatomic) IBInspectable CGFloat bottomInset;
@property (nonatomic) IBInspectable CGFloat rightInset;
@property (nonatomic) IBInspectable UIColor *placeholderColor;
@property (nonatomic) UIFont  *placehoderFont;
@property (nonatomic, weak) IBOutlet id <JXKeyInputTextFieldDelegate> keyInputDelegate;
@end
