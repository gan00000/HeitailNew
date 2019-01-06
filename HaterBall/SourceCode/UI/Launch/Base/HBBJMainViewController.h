#import "HBBJBaseTabBarController.h"
typedef NS_ENUM(NSInteger, BJMainTabIndex) {
    BJMainTabIndexMatch= 0,
    BJMainTabIndexNews,
    BJMainTabIndexFilm,
    BJMainTabIndexData,
    BJMainTabIndexRank
};
@interface HBBJMainViewController : HBBJBaseTabBarController
@property (nonatomic, assign) NSInteger currentSelectedIndex;
@end
