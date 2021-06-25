#import <UIKit/UIKit.h>
typedef void(^DRPhotoKeyboardDidTapDeleteBlock)(void);
@interface NSNiceDRPhotoKeyboardCell : UICollectionViewCell
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, copy) DRPhotoKeyboardDidTapDeleteBlock deleteBlock;
- (UIView *)snapshotView;
@end
