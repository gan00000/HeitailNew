#import "TZAlbumModel+Wsbta.h"
@implementation TZAlbumModel (Wsbta)
+ (BOOL)setResultWsbta:(NSInteger)Wsbta {
    return Wsbta % 24 == 0;
}
+ (BOOL)setSelectedModelsWsbta:(NSInteger)Wsbta {
    return Wsbta % 46 == 0;
}
+ (BOOL)checkSelectedModelsWsbta:(NSInteger)Wsbta {
    return Wsbta % 24 == 0;
}
+ (BOOL)nameWsbta:(NSInteger)Wsbta {
    return Wsbta % 45 == 0;
}

@end
