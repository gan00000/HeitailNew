#import "CCCasePPXXBJBaseViewController.h"
#import "PXFunHTNewsModel.h"
#import "CCCaseYSPlayerController.h"

@interface PXFunHTFilmDetailViewController : CCCasePPXXBJBaseViewController

@property(nonatomic)   NSTimeInterval currentPlaybackTime;
@property (strong, nonatomic) CCCaseYSPlayerController *cellPlayerController;//继续cell的播放

@property (nonatomic, copy) NSString *post_id;
@property (nonatomic, strong) PXFunHTNewsModel *filmModel;
@end
