#import <UIKit/UIKit.h>
#import <SDVersion/SDiOSVersion.h>
@interface UIView (JXDesign)
+ (CGFloat)jx_designValue:(CGFloat)value;
+ (CGFloat)jx_designValue:(CGFloat)value deviceSize:(DeviceSize)deviceSize;
@end
