#import <UIKit/UIKit.h>
@class GlodBuleTZVideoPlayerController;
typedef void (^TZVideoPlayerControllerDeleteBlock)();
@protocol TZVideoPlayerControllerDelegate <NSObject>
@optional
- (void)videoPlayerControllerDelectVideo:(GlodBuleTZVideoPlayerController *)videoPlayerController;
@end
@class GlodBuleTZAssetModel;
@interface GlodBuleTZVideoPlayerController : UIViewController
@property (weak, nonatomic) id<TZVideoPlayerControllerDelegate> delegate;
@property (copy, nonatomic) TZVideoPlayerControllerDeleteBlock deleteBlock;
@property (nonatomic, strong) GlodBuleTZAssetModel *model;
@property (strong, nonatomic) UIImage *coverImg;
@property (copy, nonatomic) NSString *videoPath;
@end
