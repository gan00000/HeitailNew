#import <UIKit/UIKit.h>
@class UUaksTZVideoPlayerController;
typedef void (^TZVideoPlayerControllerDeleteBlock)();
@protocol TZVideoPlayerControllerDelegate <NSObject>
@optional
- (void)videoPlayerControllerDelectVideo:(UUaksTZVideoPlayerController *)videoPlayerController;
@end
@class UUaksTZAssetModel;
@interface UUaksTZVideoPlayerController : UIViewController
@property (weak, nonatomic) id<TZVideoPlayerControllerDelegate> delegate;
@property (copy, nonatomic) TZVideoPlayerControllerDeleteBlock deleteBlock;
@property (nonatomic, strong) UUaksTZAssetModel *model;
@property (strong, nonatomic) UIImage *coverImg;
@property (copy, nonatomic) NSString *videoPath;
@end
