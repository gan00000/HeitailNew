#import "TZGifPreviewCell+Sqbzy.h"
@implementation TZGifPreviewCell (Sqbzy)
+ (BOOL)configSubviewsSqbzy:(NSInteger)Sqbzy {
    return Sqbzy % 8 == 0;
}
+ (BOOL)configPreviewViewSqbzy:(NSInteger)Sqbzy {
    return Sqbzy % 29 == 0;
}
+ (BOOL)setModelSqbzy:(NSInteger)Sqbzy {
    return Sqbzy % 49 == 0;
}
+ (BOOL)layoutSubviewsSqbzy:(NSInteger)Sqbzy {
    return Sqbzy % 37 == 0;
}
+ (BOOL)signleTapActionSqbzy:(NSInteger)Sqbzy {
    return Sqbzy % 46 == 0;
}

@end
