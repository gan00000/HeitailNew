#import "GGCatHTUserInfoEditViewController.h"
#import <Photos/Photos.h>
#import <TZImagePickerController.h>
#import "HourseHTUserRequest.h"
#import "MMTodayDRSandBoxManager.h"
#import "UIImageView+PXFunGlodBuleHT.h"
@interface GGCatHTUserInfoEditViewController ()
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet JXImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UIView *tipView;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLeft;
@property (weak, nonatomic) IBOutlet UILabel *emailRight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *userNameContentHeight;
@property (nonatomic, copy) NSString *selectedImageBase64;
@property (nonatomic, assign) BOOL avatarChange;
@property (nonatomic, assign) BOOL userNameChange;
@property (nonatomic, assign) BOOL emailChange;
@end
@implementation GGCatHTUserInfoEditViewController
+ (instancetype)taoviewController {
    return [[GGCatHTUserInfoEditViewController alloc] init];
}
- (void)updateUserInfo {
    GGCatHTUserInfoModel *userInfoModel = [MMTodayHTUserManager tao_userInfo];
    self.userNameLabel.text = userInfoModel.display_name;
    //    self.avatarImageView.image = userInfoModel.avatar;
    
    [self.avatarImageView th_setImageWithURL:userInfoModel.user_img placeholderImage:HT_DEFAULT_AVATAR_LOGO];
    
    self.emailLabel.text = userInfoModel.user_email;
    if (userInfoModel.user_email.length) {
        self.emailLeft.hidden = NO;
        self.emailRight.hidden = NO;
    } else {
        self.emailLeft.hidden = YES;
        self.emailRight.hidden = YES;
    }
    if (userInfoModel.change_name) {
        self.tipView.hidden = YES;
        self.userNameTextField.hidden = YES;
        self.userNameContentHeight.constant = 55;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"個人信息";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveUserInfo)];
    [self updateUserInfo];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onUserNameChagne) name:UITextFieldTextDidChangeNotification object:self.userNameTextField];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onEmailChagne) name:UITextFieldTextDidChangeNotification object:self.emailTextField];
}
#pragma mark - Actions
- (IBAction)avatarSelectAction:(UIButton *)sender {
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusAuthorized) {
        [self showTZImagePickerController];
    } else if (status == PHAuthorizationStatusDenied) {
        [MMTodayHTUserManager taophotoAlbumDenied];
    } else {
        kWeakSelf
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status){
            dispatch_async(dispatch_get_main_queue(), ^{
                if (status == PHAuthorizationStatusAuthorized){
                    [weakSelf showTZImagePickerController];
                }
            });
        }];
    }
}
- (void)saveUserInfo {
    [GGCatBJLoadingHud showHUDWithText:@"正在保存" inView:self.navigationController.view];
    NSString *email;
    NSString *userName;
    NSString *base64Avatar;
    if (self.emailChange) {
        email = self.emailTextField.text;
    }
    if (self.userNameChange) {
        userName = self.userNameTextField.text;
    }
    if (self.avatarChange) {
        base64Avatar = self.selectedImageBase64;
    }
    kWeakSelf
    [HourseHTUserRequest taoupdateUserInfoWithEmail:email displayName:userName file:base64Avatar successBlock:^(NSDictionary * _Nonnull userInfo) {
        
        [MMTodayHTUserManager tao_refreshUserInfoWithSuccessBlock:^{
            [GGCatBJLoadingHud hideHUDInView:weakSelf.navigationController.view];
            [weakSelf.view showToast:@"保存成功"];
            [weakSelf.navigationController popViewControllerAnimated:YES];
            [self updateUserInfo];
        }];
    } failBlock:^(SundayBJError *error) {
        [GGCatBJLoadingHud hideHUDInView:weakSelf.navigationController.view];
        [weakSelf.view showToast:@"保存失敗"];
    }];
}
- (void)onUserNameChagne {
    self.userNameChange = YES;
}
- (void)onEmailChagne {
    self.emailChange = YES;
}
- (BOOL)tao_shouldForbidSlideBackAction {
    return self.avatarChange || self.userNameChange || self.emailChange;
}
#pragma mark - private
- (void)showTZImagePickerController {
    CGFloat cropHeight = SCREEN_WIDTH;
    kWeakSelf
    TZImagePickerController *imagePickerViewController = [[TZImagePickerController alloc] initWithMaxImagesCount:1 columnNumber:3 delegate:nil pushPhotoPickerVc:YES];
    imagePickerViewController.isSelectOriginalPhoto = YES;
    imagePickerViewController.allowPickingVideo = NO;
    imagePickerViewController.allowCrop = YES;
    imagePickerViewController.cropRect = CGRectMake(0, (SCREEN_HEIGHT-cropHeight)/2, SCREEN_WIDTH, cropHeight);
    imagePickerViewController.naviTitleColor = [UIColor whiteColor];
    imagePickerViewController.barItemTextColor = [UIColor whiteColor];
    [imagePickerViewController setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        UIImage *image = photos.firstObject;
        NSData *data = UIImageJPEGRepresentation(image, 0.6);
        weakSelf.avatarImageView.image = [UIImage imageWithData:data];
        weakSelf.selectedImageBase64 = [data base64EncodedStringWithOptions:0];
        weakSelf.avatarChange = YES;
        BJLog(@"base64: %@", weakSelf.selectedImageBase64);
    }];
    [imagePickerViewController.navigationBar setupBackground];
    imagePickerViewController.title = @"相冊";
    [self presentViewController:imagePickerViewController animated:YES completion:nil];
}
@end
