#import "GlodBulePPXXBJBaseTabBarController.h"
typedef NS_ENUM(NSInteger, BJMainTabIndex) {
    BJMainTabIndexMatch= 0,
    BJMainTabIndexNews,
    BJMainTabIndexFilm,
    BJMainTabIndexData,
    BJMainTabIndexRank
};
@interface GlodBulePPXXBJMainViewController : GlodBulePPXXBJBaseTabBarController
@property (nonatomic, assign) NSInteger currentSelectedIndex;
@end
