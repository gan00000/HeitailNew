#import "GlodBuleTZAssetCell.h"
#import "GlodBuleTZAssetModel.h"
#import "UIView+GlodBuleLayout.h"
#import "GlodBuleTZImageManager.h"
#import "GlodBuleTZImagePickerController.h"
#import "GlodBuleTZProgressView.h"
@interface GlodBuleTZAssetCell ()
@property (weak, nonatomic) UIImageView *imageView;       
@property (weak, nonatomic) UIImageView *selectImageView;
@property (weak, nonatomic) UIView *bottomView;
@property (weak, nonatomic) UILabel *timeLength;
@property (nonatomic, weak) UIImageView *videoImgView;
@property (nonatomic, strong) GlodBuleTZProgressView *progressView;
@property (nonatomic, assign) int32_t bigImageRequestID;
@end
@implementation GlodBuleTZAssetCell
- (void)setModel:(GlodBuleTZAssetModel *)model {
    _model = model;
    if (iOS8Later) {
        self.representedAssetIdentifier = [[GlodBuleTZImageManager manager] getAssetIdentifier:model.asset];
    }
    int32_t imageRequestID = [[GlodBuleTZImageManager manager] getPhotoWithAsset:model.asset photoWidth:self.tz_width completion:^(UIImage *photo, NSDictionary *info, BOOL isDegraded) {
        if (_progressView) {
            self.progressView.hidden = YES;
            self.imageView.alpha = 1.0;
        }
        if (!iOS8Later) {
            self.imageView.image = photo; return;
        }
        if ([self.representedAssetIdentifier isEqualToString:[[GlodBuleTZImageManager manager] getAssetIdentifier:model.asset]]) {
            self.imageView.image = photo;
        } else {
            [[PHImageManager defaultManager] cancelImageRequest:self.imageRequestID];
        }
        if (!isDegraded) {
            self.imageRequestID = 0;
        }
    } progressHandler:nil networkAccessAllowed:NO];
    if (imageRequestID && self.imageRequestID && imageRequestID != self.imageRequestID) {
        [[PHImageManager defaultManager] cancelImageRequest:self.imageRequestID];
    }
    self.imageRequestID = imageRequestID;
    self.selectPhotoButton.selected = model.isSelected;
    self.selectImageView.image = self.selectPhotoButton.isSelected ? [UIImage imageNamedFromMyBundle:self.photoSelImageName] : [UIImage imageNamedFromMyBundle:self.photoDefImageName];
    self.type = (NSInteger)model.type;
    if (![[GlodBuleTZImageManager manager] isPhotoSelectableWithAsset:model.asset]) {
        if (_selectImageView.hidden == NO) {
            self.selectPhotoButton.hidden = YES;
            _selectImageView.hidden = YES;
        }
    }
    if (model.isSelected) {
        [self fetchBigImage];
    }
    [self setNeedsLayout];
}
- (void)setShowSelectBtn:(BOOL)showSelectBtn {
    _showSelectBtn = showSelectBtn;
    if (!self.selectPhotoButton.hidden) {
        self.selectPhotoButton.hidden = !showSelectBtn;
    }
    if (!self.selectImageView.hidden) {
        self.selectImageView.hidden = !showSelectBtn;
    }
}
- (void)setType:(TZAssetCellType)type {
    _type = type;
    if (type == TZAssetCellTypePhoto || type == TZAssetCellTypeLivePhoto || (type == TZAssetCellTypePhotoGif && !self.allowPickingGif) || self.allowPickingMultipleVideo) {
        _selectImageView.hidden = NO;
        _selectPhotoButton.hidden = NO;
        _bottomView.hidden = YES;
    } else { 
        _selectImageView.hidden = YES;
        _selectPhotoButton.hidden = YES;
    }
    if (type == TZAssetCellTypeVideo) {
        self.bottomView.hidden = NO;
        self.timeLength.text = _model.timeLength;
        self.videoImgView.hidden = NO;
        _timeLength.tz_left = self.videoImgView.tz_right;
        _timeLength.textAlignment = NSTextAlignmentRight;
    } else if (type == TZAssetCellTypePhotoGif && self.allowPickingGif) {
        self.bottomView.hidden = NO;
        self.timeLength.text = @"GIF";
        self.videoImgView.hidden = YES;
        _timeLength.tz_left = 5;
        _timeLength.textAlignment = NSTextAlignmentLeft;
    }
}
- (void)selectPhotoButtonClick:(UIButton *)sender {
    if (self.didSelectPhotoBlock) {
        self.didSelectPhotoBlock(sender.isSelected);
    }
    self.selectImageView.image = sender.isSelected ? [UIImage imageNamedFromMyBundle:self.photoSelImageName] : [UIImage imageNamedFromMyBundle:self.photoDefImageName];
    if (sender.isSelected) {
        [UIView showOscillatoryAnimationWithLayer:_selectImageView.layer type:TZOscillatoryAnimationToBigger];
        [self fetchBigImage];
    } else { 
        if (_bigImageRequestID && _progressView) {
            [[PHImageManager defaultManager] cancelImageRequest:_bigImageRequestID];
            [self hideProgressView];
        }
    }
}
- (void)hideProgressView {
    self.progressView.hidden = YES;
    self.imageView.alpha = 1.0;
}
- (void)fetchBigImage {
    _bigImageRequestID = [[GlodBuleTZImageManager manager] getPhotoWithAsset:_model.asset completion:^(UIImage *photo, NSDictionary *info, BOOL isDegraded) {
        if (_progressView) {
            [self hideProgressView];
        }
    } progressHandler:^(double progress, NSError *error, BOOL *stop, NSDictionary *info) {
        if (_model.isSelected) {
            progress = progress > 0.02 ? progress : 0.02;;
            self.progressView.progress = progress;
            self.progressView.hidden = NO;
            self.imageView.alpha = 0.4;
            if (progress >= 1) {
                [self hideProgressView];
            }
        } else {
            *stop = YES;
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        }
    } networkAccessAllowed:YES];
}
#pragma mark - Lazy load
- (UIButton *)selectPhotoButton {
    if (_selectImageView == nil) {
        UIButton *selectPhotoButton = [[UIButton alloc] init];
        [selectPhotoButton addTarget:self action:@selector(selectPhotoButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:selectPhotoButton];
        _selectPhotoButton = selectPhotoButton;
    }
    return _selectPhotoButton;
}
- (UIImageView *)imageView {
    if (_imageView == nil) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        [self.contentView addSubview:imageView];
        _imageView = imageView;
        [self.contentView bringSubviewToFront:_selectImageView];
        [self.contentView bringSubviewToFront:_bottomView];
    }
    return _imageView;
}
- (UIImageView *)selectImageView {
    if (_selectImageView == nil) {
        UIImageView *selectImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:selectImageView];
        _selectImageView = selectImageView;
    }
    return _selectImageView;
}
- (UIView *)bottomView {
    if (_bottomView == nil) {
        UIView *bottomView = [[UIView alloc] init];
        static NSInteger rgb = 0;
        bottomView.backgroundColor = [UIColor colorWithRed:rgb green:rgb blue:rgb alpha:0.8];
        [self.contentView addSubview:bottomView];
        _bottomView = bottomView;
    }
    return _bottomView;
}
- (UIImageView *)videoImgView {
    if (_videoImgView == nil) {
        UIImageView *videoImgView = [[UIImageView alloc] init];
        [videoImgView setImage:[UIImage imageNamedFromMyBundle:@"VideoSendIcon"]];
        [self.bottomView addSubview:videoImgView];
        _videoImgView = videoImgView;
    }
    return _videoImgView;
}
- (UILabel *)timeLength {
    if (_timeLength == nil) {
        UILabel *timeLength = [[UILabel alloc] init];
        timeLength.font = [UIFont boldSystemFontOfSize:11];
        timeLength.textColor = [UIColor whiteColor];
        timeLength.textAlignment = NSTextAlignmentRight;
        [self.bottomView addSubview:timeLength];
        _timeLength = timeLength;
    }
    return _timeLength;
}
- (GlodBuleTZProgressView *)progressView {
    if (_progressView == nil) {
        _progressView = [[GlodBuleTZProgressView alloc] init];
        _progressView.hidden = YES;
        [self addSubview:_progressView];
    }
    return _progressView;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.allowPreview) {
        _selectPhotoButton.frame = CGRectMake(self.tz_width - 44, 0, 44, 44);
    } else {
        _selectPhotoButton.frame = self.bounds;
    }
    _selectImageView.frame = CGRectMake(self.tz_width - 27, 0, 27, 27);
    _imageView.frame = CGRectMake(0, 0, self.tz_width, self.tz_height);
    static CGFloat progressWH = 20;
    CGFloat progressXY = (self.tz_width - progressWH) / 2;
    _progressView.frame = CGRectMake(progressXY, progressXY, progressWH, progressWH);
    _bottomView.frame = CGRectMake(0, self.tz_height - 17, self.tz_width, 17);
    _videoImgView.frame = CGRectMake(8, 0, 17, 17);
    _timeLength.frame = CGRectMake(self.videoImgView.tz_right, 0, self.tz_width - self.videoImgView.tz_right - 5, 17);
    self.type = (NSInteger)self.model.type;
    self.showSelectBtn = self.showSelectBtn;
}
@end
@interface TZAlbumCell ()
@property (weak, nonatomic) UIImageView *posterImageView;
@property (weak, nonatomic) UILabel *titleLabel;
@end
@implementation TZAlbumCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return self;
}
- (void)setModel:(TZAlbumModel *)model {
    _model = model;
    NSMutableAttributedString *nameString = [[NSMutableAttributedString alloc] initWithString:model.name attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16],NSForegroundColorAttributeName:[UIColor blackColor]}];
    NSAttributedString *countString = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"  (%zd)",model.count] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16],NSForegroundColorAttributeName:[UIColor lightGrayColor]}];
    [nameString appendAttributedString:countString];
    self.titleLabel.attributedText = nameString;
    [[GlodBuleTZImageManager manager] getPostImageWithAlbumModel:model completion:^(UIImage *postImage) {
        self.posterImageView.image = postImage;
    }];
    if (model.selectedCount) {
        self.selectedCountButton.hidden = NO;
        [self.selectedCountButton setTitle:[NSString stringWithFormat:@"%zd",model.selectedCount] forState:UIControlStateNormal];
    } else {
        self.selectedCountButton.hidden = YES;
    }
}
- (void)layoutSubviews {
    if (iOS7Later) [super layoutSubviews];
    _selectedCountButton.frame = CGRectMake(self.tz_width - 24 - 30, 23, 24, 24);
    NSInteger titleHeight = ceil(self.titleLabel.font.lineHeight);
    self.titleLabel.frame = CGRectMake(80, (self.tz_height - titleHeight) / 2, self.tz_width - 80 - 50, titleHeight);
    self.posterImageView.frame = CGRectMake(0, 0, 70, 70);
}
- (void)layoutSublayersOfLayer:(CALayer *)layer {
    if (iOS7Later) [super layoutSublayersOfLayer:layer];
}
#pragma mark - Lazy load
- (UIImageView *)posterImageView {
    if (_posterImageView == nil) {
        UIImageView *posterImageView = [[UIImageView alloc] init];
        posterImageView.contentMode = UIViewContentModeScaleAspectFill;
        posterImageView.clipsToBounds = YES;
        [self.contentView addSubview:posterImageView];
        _posterImageView = posterImageView;
    }
    return _posterImageView;
}
- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.font = [UIFont boldSystemFontOfSize:17];
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:titleLabel];
        _titleLabel = titleLabel;
    }
    return _titleLabel;
}
- (UIButton *)selectedCountButton {
    if (_selectedCountButton == nil) {
        UIButton *selectedCountButton = [[UIButton alloc] init];
        selectedCountButton.layer.cornerRadius = 12;
        selectedCountButton.clipsToBounds = YES;
        selectedCountButton.backgroundColor = [UIColor redColor];
        [selectedCountButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        selectedCountButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:selectedCountButton];
        _selectedCountButton = selectedCountButton;
    }
    return _selectedCountButton;
}
@end
@implementation TZAssetCameraCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _imageView = [[UIImageView alloc] init];
        _imageView.backgroundColor = [UIColor colorWithWhite:1.000 alpha:0.500];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:_imageView];
        self.clipsToBounds = YES;
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _imageView.frame = self.bounds;
}
@end