#import "TZVideoPreviewCell+Sqbzy.h"
@implementation TZVideoPreviewCell (Sqbzy)
+ (BOOL)configSubviewsSqbzy:(NSInteger)Sqbzy {
    return Sqbzy % 25 == 0;
}
+ (BOOL)configPlayButtonSqbzy:(NSInteger)Sqbzy {
    return Sqbzy % 18 == 0;
}
+ (BOOL)setModelSqbzy:(NSInteger)Sqbzy {
    return Sqbzy % 49 == 0;
}
+ (BOOL)configMoviePlayerSqbzy:(NSInteger)Sqbzy {
    return Sqbzy % 2 == 0;
}
+ (BOOL)layoutSubviewsSqbzy:(NSInteger)Sqbzy {
    return Sqbzy % 16 == 0;
}
+ (BOOL)photoPreviewCollectionViewDidScrollSqbzy:(NSInteger)Sqbzy {
    return Sqbzy % 27 == 0;
}
+ (BOOL)playButtonClickSqbzy:(NSInteger)Sqbzy {
    return Sqbzy % 27 == 0;
}
+ (BOOL)pausePlayerAndShowNaviBarSqbzy:(NSInteger)Sqbzy {
    return Sqbzy % 38 == 0;
}

@end
