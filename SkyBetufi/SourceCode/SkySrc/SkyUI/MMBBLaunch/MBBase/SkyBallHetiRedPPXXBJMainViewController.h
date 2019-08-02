#import "SkyBallHetiRedPPXXBJBaseTabBarController.h"
typedef NS_ENUM(NSInteger, BJMainTabIndex) {
    BJMainTabIndexMatch= 0,
    BJMainTabIndexNews,
    BJMainTabIndexFilm,
    BJMainTabIndexData,
    BJMainTabIndexRank
};
@interface SkyBallHetiRedPPXXBJMainViewController : SkyBallHetiRedPPXXBJBaseTabBarController
@property (nonatomic, assign) NSInteger currentSelectedIndex;
@end
