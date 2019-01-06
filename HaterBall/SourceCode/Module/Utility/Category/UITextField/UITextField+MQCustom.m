#import "UITextField+MQCustom.h"
#import <objc/runtime.h>
static const char max_length = '\0';
static const char value_changed_block = '\0';
static const char kObsever = '\0';
static const char kDisableEmoji = '\0';
@interface UITextField ()
@property (assign,nonatomic,getter=isObsevered) BOOL obsever;
@end
@implementation UITextField (MQCustom)
-(void)setDisableEmoji:(BOOL)disableEmoji{
    objc_setAssociatedObject(self, &kDisableEmoji, [NSNumber numberWithBool:disableEmoji], OBJC_ASSOCIATION_RETAIN);
}
-(BOOL)isDisableEmoji{
    return [objc_getAssociatedObject(self, &kDisableEmoji) boolValue];
}
-(BOOL)isObsevered{
    return [objc_getAssociatedObject(self, &kObsever) boolValue];
}
-(void)setObsever:(BOOL)obsever{
    objc_setAssociatedObject(self, &kObsever, [NSNumber numberWithBool:obsever], OBJC_ASSOCIATION_RETAIN);
}
-(NSUInteger)maxLength{
    return [objc_getAssociatedObject(self, &max_length) integerValue];
}
-(void)setMaxLength:(NSUInteger)maxLength{
    objc_setAssociatedObject(self, &max_length, @(maxLength), OBJC_ASSOCIATION_RETAIN);
    if (!self.isObsevered) {
        [self addTarget:self action:@selector(mq_textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        self.obsever = YES;
    }
}
-(void)setValueChangedBlock:(void (^)(NSString *))valueChangedBlock{
    objc_setAssociatedObject(self, &value_changed_block, valueChangedBlock, OBJC_ASSOCIATION_COPY);
    if (!self.isObsevered) {
        [self addTarget:self action:@selector(mq_textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        self.obsever = YES;
    }
}
-(void(^)(NSString *))valueChangedBlock{
    return objc_getAssociatedObject(self, &value_changed_block);
}
- (void)mq_textFieldDidChange:(UITextField *)textField
{
    NSUInteger kMaxLength = [objc_getAssociatedObject(self, &max_length) integerValue];
    if (kMaxLength == 0) {
        kMaxLength = NSIntegerMax;
    }
    NSString *toBeString = textField.text;
    UITextRange *selectedRange = [textField markedTextRange];
    UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
    if (!position)
    {
        if (toBeString.length > kMaxLength)
        {
            NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:kMaxLength];
            if (rangeIndex.length == 1)
            {
                textField.text = [toBeString substringToIndex:kMaxLength];
            }
            else
            {
                NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, kMaxLength)];
                NSInteger tmpLength;
                if (rangeRange.length > kMaxLength) {
                    tmpLength = rangeRange.length - rangeIndex.length;
                }else{
                    tmpLength = rangeRange.length;
                }
                textField.text = [toBeString substringWithRange:NSMakeRange(0, tmpLength)];
            }
        }
    }
    if (self.valueChangedBlock) {
        self.valueChangedBlock(self.text);
    }
}
@end
