#import <UIKit/UIKit.h>
@interface UITextField (XRRFATKMQCustom)
@property (assign,nonatomic) NSUInteger maxLength;
@property (copy,nonatomic) void(^valueChangedBlock)(NSString *content);
@end
