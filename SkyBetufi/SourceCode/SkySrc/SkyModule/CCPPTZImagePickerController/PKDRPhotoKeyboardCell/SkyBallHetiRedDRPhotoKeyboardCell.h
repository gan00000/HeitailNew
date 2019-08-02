#import <UIKit/UIKit.h>
typedef void(^DRPhotoKeyboardDidTapDeleteBlock)(void);
@interface SkyBallHetiRedDRPhotoKeyboardCell : UICollectionViewCell
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, copy) DRPhotoKeyboardDidTapDeleteBlock deleteBlock;
- (UIView *)snapshotView;
@end
