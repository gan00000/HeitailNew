#import <UIKit/UIKit.h>
@interface UITextField (SkyBallHetiRedMQCustom)
@property (assign,nonatomic) NSUInteger maxLength;
@property (copy,nonatomic) void(^valueChangedBlock)(NSString *content);
@end
