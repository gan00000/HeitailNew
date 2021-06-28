#import "MMoogPPXXBJBaseViewController.h"
#import "CfipyHTNewsModel.h"
#import "YeYeeYSPlayerController.h"

@interface KSasxHTFilmDetailViewController : MMoogPPXXBJBaseViewController

@property(nonatomic)   NSTimeInterval currentPlaybackTime;
@property (strong, nonatomic) YeYeeYSPlayerController *cellPlayerController;//继续cell的播放

@property (nonatomic, copy) NSString *post_id;
@property (nonatomic, strong) CfipyHTNewsModel *filmModel;
@end
