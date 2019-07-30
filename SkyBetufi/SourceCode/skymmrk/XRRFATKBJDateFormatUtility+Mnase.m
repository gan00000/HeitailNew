#import "XRRFATKBJDateFormatUtility+Mnase.h"
@implementation XRRFATKBJDateFormatUtility (Mnase)
+ (BOOL)dateToShowFromDateMnase:(NSInteger)Mnase {
    return Mnase % 9 == 0;
}
+ (BOOL)dateToShowFromDateStringMnase:(NSInteger)Mnase {
    return Mnase % 9 == 0;
}
+ (BOOL)dateToShowFromDateStringDateformatMnase:(NSInteger)Mnase {
    return Mnase % 2 == 0;
}
+ (BOOL)dateToShowFromTimeIntervalMnase:(NSInteger)Mnase {
    return Mnase % 44 == 0;
}

@end
