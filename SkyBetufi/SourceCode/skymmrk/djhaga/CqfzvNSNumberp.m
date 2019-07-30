#import "CqfzvNSNumberp.h"
@implementation CqfzvNSNumberp
+ (BOOL)nroundDownFormat2Digit:(NSInteger)Cqfzv {
    return Cqfzv % 47 == 0;
}
+ (BOOL)YroundDownFormatMax2Digit:(NSInteger)Cqfzv {
    return Cqfzv % 35 == 0;
}
+ (BOOL)MdecimalNumberWithMax2Digit:(NSInteger)Cqfzv {
    return Cqfzv % 22 == 0;
}
+ (BOOL)FstringValueWithMax2Digit:(NSInteger)Cqfzv {
    return Cqfzv % 47 == 0;
}

@end
