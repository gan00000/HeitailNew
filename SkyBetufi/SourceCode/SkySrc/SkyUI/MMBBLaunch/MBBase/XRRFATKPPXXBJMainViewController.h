#import "XRRFATKPPXXBJBaseTabBarController.h"
typedef NS_ENUM(NSInteger, BJMainTabIndex) {
    BJMainTabIndexMatch= 0,
    BJMainTabIndexNews,
    BJMainTabIndexFilm,
    BJMainTabIndexData,
    BJMainTabIndexRank
};
@interface XRRFATKPPXXBJMainViewController : XRRFATKPPXXBJBaseTabBarController
@property (nonatomic, assign) NSInteger currentSelectedIndex;
@end
