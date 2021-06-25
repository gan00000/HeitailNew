#import <UIKit/UIKit.h>
@class KSasxTZVideoPlayerController;
typedef void (^TZVideoPlayerControllerDeleteBlock)();
@protocol TZVideoPlayerControllerDelegate <NSObject>
@optional
- (void)videoPlayerControllerDelectVideo:(KSasxTZVideoPlayerController *)videoPlayerController;
@end
@class UUaksTZAssetModel;
@interface KSasxTZVideoPlayerController : UIViewController
@property (weak, nonatomic) id<TZVideoPlayerControllerDelegate> delegate;
@property (copy, nonatomic) TZVideoPlayerControllerDeleteBlock deleteBlock;
@property (nonatomic, strong) UUaksTZAssetModel *model;
@property (strong, nonatomic) UIImage *coverImg;
@property (copy, nonatomic) NSString *videoPath;
@end
