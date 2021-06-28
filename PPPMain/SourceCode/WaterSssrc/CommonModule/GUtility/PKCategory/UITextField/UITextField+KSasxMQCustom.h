#import <UIKit/UIKit.h>
@interface UITextField (KSasxMQCustom)
@property (assign,nonatomic) NSUInteger maxLength;
@property (copy,nonatomic) void(^valueChangedBlock)(NSString *content);
@end
