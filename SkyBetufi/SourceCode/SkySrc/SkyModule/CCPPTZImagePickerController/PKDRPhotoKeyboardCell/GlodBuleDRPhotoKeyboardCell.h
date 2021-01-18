#import <UIKit/UIKit.h>
typedef void(^DRPhotoKeyboardDidTapDeleteBlock)(void);
@interface GlodBuleDRPhotoKeyboardCell : UICollectionViewCell
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, copy) DRPhotoKeyboardDidTapDeleteBlock deleteBlock;
- (UIView *)snapshotView;
@end
