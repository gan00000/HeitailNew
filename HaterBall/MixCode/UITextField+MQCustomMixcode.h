#import <UIKit/UIKit.h>
#import "UITextField+MQCustom.h"
#import <objc/runtime.h>

@interface UITextField (MQCustomMixcode)
- (void)setDisableEmoji:(BOOL)disableEmoji mixcode:(NSString *)mixcode;
- (void)isDisableEmojiMixcode:(NSString *)mixcode;
- (void)isObseveredMixcode:(NSString *)mixcode;
- (void)setObsever:(BOOL)obsever mixcode:(NSString *)mixcode;
- (void)maxLengthMixcode:(NSString *)mixcode;
- (void)setMaxLength:(NSUInteger)maxLength mixcode:(NSString *)mixcode;
- (void)setValueChangedBlock:(void (^)(NSString *))valueChangedBlock mixcode:(NSString *)mixcode;
- (void)valueChangedBlockMixcode:(NSString *)mixcode;
- (void)mq_textFieldDidChange:(UITextField *)textField mixcode:(NSString *)mixcode;

@end
