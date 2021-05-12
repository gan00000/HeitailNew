#import <UIKit/UIKit.h>
@class TZAlbumModel;
@interface YYPackageTZPhotoPickerController : UIViewController
@property (nonatomic, assign) BOOL isFirstAppear;
@property (nonatomic, assign) NSInteger columnNumber;
@property (nonatomic, strong) TZAlbumModel *model;
@end
@interface TZCollectionView : UICollectionView
@end
