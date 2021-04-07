#import "GlodBulePPXXBJBaseViewController.h"
#import "GlodBuleHTNewsModel.h"
#import "YSPlayerController.h"

@interface GlodBuleHTFilmDetailViewController : GlodBulePPXXBJBaseViewController

@property(nonatomic)   NSTimeInterval currentPlaybackTime;
@property (strong, nonatomic) YSPlayerController *cellPlayerController;//继续cell的播放

@property (nonatomic, copy) NSString *post_id;
@property (nonatomic, strong) GlodBuleHTNewsModel *filmModel;
@end
