#import <UIKit/UIKit.h>
#import "GGCatTZAssetModel.h"
#import "NSBundle+YYPackageGlodBuleTZImagePicker.h"
#define iOS7Later ([UIDevice currentDevice].systemVersion.floatValue >= 7.0f)
#define iOS8Later ([UIDevice currentDevice].systemVersion.floatValue >= 8.0f)
#define iOS9Later ([UIDevice currentDevice].systemVersion.floatValue >= 9.0f)
#define iOS9_1Later ([UIDevice currentDevice].systemVersion.floatValue >= 9.1f)
#define TZ_isGlobalHideStatusBar [[[NSBundle mainBundle] objectForInfoDictionaryKey:@"UIStatusBarHidden"] boolValue]
@protocol TZImagePickerControllerDelegate;
@interface GGCatTZImagePickerController : UINavigationController
- (instancetype)initWithMaxImagesCount:(NSInteger)maxImagesCount delegate:(id<TZImagePickerControllerDelegate>)delegate;
- (instancetype)initWithMaxImagesCount:(NSInteger)maxImagesCount columnNumber:(NSInteger)columnNumber delegate:(id<TZImagePickerControllerDelegate>)delegate;
- (instancetype)initWithMaxImagesCount:(NSInteger)maxImagesCount columnNumber:(NSInteger)columnNumber delegate:(id<TZImagePickerControllerDelegate>)delegate pushPhotoPickerVc:(BOOL)pushPhotoPickerVc;
- (instancetype)initWithSelectedAssets:(NSMutableArray *)selectedAssets selectedPhotos:(NSMutableArray *)selectedPhotos index:(NSInteger)index;
- (instancetype)initCropTypeWithAsset:(id)asset photo:(UIImage *)photo completion:(void (^)(UIImage *cropImage,id asset))completion;
@property (nonatomic, assign) NSInteger maxImagesCount;
@property (nonatomic, assign) NSInteger minImagesCount;
@property (nonatomic, assign) BOOL alwaysEnableDoneBtn;
@property (nonatomic, assign) BOOL sortAscendingByModificationDate;
@property (nonatomic, assign) CGFloat photoWidth;
@property (nonatomic, assign) CGFloat photoPreviewMaxWidth;
@property (nonatomic, assign) NSInteger timeout;
@property (nonatomic, assign) BOOL allowPickingOriginalPhoto;
@property (nonatomic, assign) BOOL allowPickingVideo;
@property (nonatomic, assign) BOOL allowPickingMultipleVideo;
@property (nonatomic, assign) BOOL allowPickingGif;
@property(nonatomic, assign) BOOL allowPickingImage;
@property(nonatomic, assign) BOOL allowTakePicture;
@property (nonatomic, assign) BOOL allowPreview;
@property(nonatomic, assign) BOOL autoDismiss;
@property (nonatomic, strong) NSMutableArray *selectedAssets;
@property (nonatomic, strong) NSMutableArray<GGCatTZAssetModel *> *selectedModels;
@property (nonatomic, assign) NSInteger minPhotoWidthSelectable;
@property (nonatomic, assign) NSInteger minPhotoHeightSelectable;
@property (nonatomic, assign) BOOL hideWhenCanNotSelect;
@property (nonatomic, assign) BOOL isStatusBarDefault;
@property (nonatomic, assign) BOOL showSelectBtn;        
@property (nonatomic, assign) BOOL allowCrop;            
@property (nonatomic, assign) CGRect cropRect;           
@property (nonatomic, assign) CGRect cropRectPortrait;   
@property (nonatomic, assign) CGRect cropRectLandscape;  
@property (nonatomic, assign) BOOL needCircleCrop;       
@property (nonatomic, assign) NSInteger circleCropRadius;  
@property (nonatomic, copy) void (^cropViewSettingBlock)(UIView *cropView);     
@property (nonatomic, copy) void (^navLeftBarButtonSettingBlock)(UIButton *leftButton);     
- (id)showAlertWithTitle:(NSString *)title;
- (void)hideAlertView:(id)alertView;
- (void)showProgressHUD;
- (void)hideProgressHUD;
@property (nonatomic, assign) BOOL isSelectOriginalPhoto;
@property (nonatomic, copy) NSString *takePictureImageName;
@property (nonatomic, copy) NSString *photoSelImageName;
@property (nonatomic, copy) NSString *photoDefImageName;
@property (nonatomic, copy) NSString *photoOriginSelImageName;
@property (nonatomic, copy) NSString *photoOriginDefImageName;
@property (nonatomic, copy) NSString *photoPreviewOriginDefImageName;
@property (nonatomic, copy) NSString *photoNumberIconImageName;
@property (nonatomic, strong) UIColor *oKButtonTitleColorNormal;
@property (nonatomic, strong) UIColor *oKButtonTitleColorDisabled;
@property (nonatomic, strong) UIColor *naviBgColor;
@property (nonatomic, strong) UIColor *naviTitleColor;
@property (nonatomic, strong) UIFont *naviTitleFont;
@property (nonatomic, strong) UIColor *barItemTextColor;
@property (nonatomic, strong) UIFont *barItemTextFont;
@property (nonatomic, copy) NSString *doneBtnTitleStr;
@property (nonatomic, copy) NSString *cancelBtnTitleStr;
@property (nonatomic, copy) NSString *previewBtnTitleStr;
@property (nonatomic, copy) NSString *fullImageBtnTitleStr;
@property (nonatomic, copy) NSString *settingBtnTitleStr;
@property (nonatomic, copy) NSString *processHintStr;
- (void)cancelButtonClick;
@property (nonatomic, copy) void (^didFinishPickingPhotosHandle)(NSArray<UIImage *> *photos,NSArray *assets,BOOL isSelectOriginalPhoto);
@property (nonatomic, copy) void (^didFinishPickingPhotosWithInfosHandle)(NSArray<UIImage *> *photos,NSArray *assets,BOOL isSelectOriginalPhoto,NSArray<NSDictionary *> *infos);
@property (nonatomic, copy) void (^imagePickerControllerDidCancelHandle)();
@property (nonatomic, copy) void (^didFinishPickingVideoHandle)(UIImage *coverImage,id asset);
@property (nonatomic, copy) void (^didFinishPickingGifImageHandle)(UIImage *animatedImage,id sourceAssets);
@property (nonatomic, weak) id<TZImagePickerControllerDelegate> pickerDelegate;
@end
@protocol TZImagePickerControllerDelegate <NSObject>
@optional
- (void)imagePickerController:(GGCatTZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto;
- (void)imagePickerController:(GGCatTZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto infos:(NSArray<NSDictionary *> *)infos;
- (void)tz_imagePickerControllerDidCancel:(GGCatTZImagePickerController *)picker;
- (void)imagePickerController:(GGCatTZImagePickerController *)picker didFinishPickingVideo:(UIImage *)coverImage sourceAssets:(id)asset;
- (void)imagePickerController:(GGCatTZImagePickerController *)picker didFinishPickingGifImage:(UIImage *)animatedImage sourceAssets:(id)asset;
- (BOOL)isAlbumCanSelect:(NSString *)albumName result:(id)result;
- (BOOL)isAssetCanSelect:(id)asset;
@end
@interface TZAlbumPickerController : UIViewController
@property (nonatomic, assign) NSInteger columnNumber;
- (void)configTableView;
@end
@interface UIImage (MyBundle)
+ (UIImage *)imageNamedFromMyBundle:(NSString *)name;
@end
@interface NSString (TzExtension)
- (BOOL)tz_containsString:(NSString *)string;
@end
