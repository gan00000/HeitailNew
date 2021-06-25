#import <UIKit/UIKit.h>
@interface UITextField (GGCatMQCustom)
@property (assign,nonatomic) NSUInteger maxLength;
@property (copy,nonatomic) void(^valueChangedBlock)(NSString *content);
@end
