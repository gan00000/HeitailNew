#import <UIKit/UIKit.h>
@class XRRFATKTZVideoPlayerController;
typedef void (^TZVideoPlayerControllerDeleteBlock)();
@protocol TZVideoPlayerControllerDelegate <NSObject>
@optional
- (void)videoPlayerControllerDelectVideo:(XRRFATKTZVideoPlayerController *)videoPlayerController;
@end
@class XRRFATKTZAssetModel;
@interface XRRFATKTZVideoPlayerController : UIViewController
@property (weak, nonatomic) id<TZVideoPlayerControllerDelegate> delegate;
@property (copy, nonatomic) TZVideoPlayerControllerDeleteBlock deleteBlock;
@property (nonatomic, strong) XRRFATKTZAssetModel *model;
@property (strong, nonatomic) UIImage *coverImg;
@property (copy, nonatomic) NSString *videoPath;
@end
