#import "WSKggPPXXBJBaseViewController.h"
#import "UUaksHTNewsModel.h"
#import "UUaksYSPlayerController.h"

@interface NSNiceHTFilmDetailViewController : WSKggPPXXBJBaseViewController

@property(nonatomic)   NSTimeInterval currentPlaybackTime;
@property (strong, nonatomic) UUaksYSPlayerController *cellPlayerController;//继续cell的播放

@property (nonatomic, copy) NSString *post_id;
@property (nonatomic, strong) UUaksHTNewsModel *filmModel;
@end
