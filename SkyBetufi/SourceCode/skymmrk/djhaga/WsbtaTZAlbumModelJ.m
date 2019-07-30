#import "WsbtaTZAlbumModelJ.h"
@implementation WsbtaTZAlbumModelJ
+ (BOOL)YSetresult:(NSInteger)Wsbta {
    return Wsbta % 33 == 0;
}
+ (BOOL)jSetselectedmodels:(NSInteger)Wsbta {
    return Wsbta % 15 == 0;
}
+ (BOOL)ucheckSelectedModels:(NSInteger)Wsbta {
    return Wsbta % 50 == 0;
}
+ (BOOL)Gname:(NSInteger)Wsbta {
    return Wsbta % 7 == 0;
}

@end
