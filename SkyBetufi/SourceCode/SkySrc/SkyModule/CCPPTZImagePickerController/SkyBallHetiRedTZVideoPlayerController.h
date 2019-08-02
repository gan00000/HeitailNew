#import <UIKit/UIKit.h>
@class SkyBallHetiRedTZVideoPlayerController;
typedef void (^TZVideoPlayerControllerDeleteBlock)();
@protocol TZVideoPlayerControllerDelegate <NSObject>
@optional
- (void)videoPlayerControllerDelectVideo:(SkyBallHetiRedTZVideoPlayerController *)videoPlayerController;
@end
@class SkyBallHetiRedTZAssetModel;
@interface SkyBallHetiRedTZVideoPlayerController : UIViewController
@property (weak, nonatomic) id<TZVideoPlayerControllerDelegate> delegate;
@property (copy, nonatomic) TZVideoPlayerControllerDeleteBlock deleteBlock;
@property (nonatomic, strong) SkyBallHetiRedTZAssetModel *model;
@property (strong, nonatomic) UIImage *coverImg;
@property (copy, nonatomic) NSString *videoPath;
@end
