#import "XRRFATKHTNewsAdditionRequest+Vjwiw.h"
@implementation XRRFATKHTNewsAdditionRequest (Vjwiw)
+ (BOOL)skargrequestNormalCommentWithOffsetNewsidSuccessblockFailblockVjwiw:(NSInteger)Vjwiw {
    return Vjwiw % 31 == 0;
}
+ (BOOL)skargrequestHotCommentWithOffsetNewsidSuccessblockFailblockVjwiw:(NSInteger)Vjwiw {
    return Vjwiw % 27 == 0;
}
+ (BOOL)skargrequestAllCommentWithPostIdSuccessblockFailblockVjwiw:(NSInteger)Vjwiw {
    return Vjwiw % 49 == 0;
}
+ (BOOL)skargrequestDetailWithPostIdSuccessblockErrorblockVjwiw:(NSInteger)Vjwiw {
    return Vjwiw % 46 == 0;
}

@end
