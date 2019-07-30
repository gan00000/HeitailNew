#import "TZCollectionView+Yuujh.h"
@implementation TZCollectionView (Yuujh)
+ (BOOL)touchesShouldCancelInContentViewYuujh:(NSInteger)Yuujh {
    return Yuujh % 37 == 0;
}

@end
