#import <UIKit/UIKit.h>
typedef void(^DRPhotoKeyboardDidTapDeleteBlock)(void);
@interface FFlaliDRPhotoKeyboardCell : UICollectionViewCell
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, copy) DRPhotoKeyboardDidTapDeleteBlock deleteBlock;
- (UIView *)snapshotView;
@end
