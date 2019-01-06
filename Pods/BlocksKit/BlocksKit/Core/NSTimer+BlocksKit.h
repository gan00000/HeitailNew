#import <Foundation/Foundation.h>
@interface NSTimer (BlocksKit)
+ (NSTimer *)bk_scheduledTimerWithTimeInterval:(NSTimeInterval)inTimeInterval block:(void (^)(NSTimer *timer))inBlock repeats:(BOOL)inRepeats;
+ (NSTimer *)bk_timerWithTimeInterval:(NSTimeInterval)inTimeInterval block:(void (^)(NSTimer *timer))inBlock repeats:(BOOL)inRepeats;
@end
