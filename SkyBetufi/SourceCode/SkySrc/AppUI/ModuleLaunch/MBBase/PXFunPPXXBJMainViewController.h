#import "HoursePPXXBJBaseTabBarController.h"
#import "MMDrawerController.h"

typedef NS_ENUM(NSInteger, BJMainTabIndex) {
    BJMainTabIndexMatch= 0,
    BJMainTabIndexNews,
    BJMainTabIndexFilm,
    BJMainTabIndexData,
    BJMainTabIndexRank
};
@interface PXFunPPXXBJMainViewController : HoursePPXXBJBaseTabBarController
@property (nonatomic, assign) NSInteger currentSelectedIndex;

@property (nonatomic,strong) MMDrawerController * drawerController;

@end
