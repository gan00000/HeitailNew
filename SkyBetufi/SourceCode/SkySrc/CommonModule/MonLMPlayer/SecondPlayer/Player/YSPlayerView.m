//
//  YSPlayerView.m
//  ijkplayerDemo
//
//  Created by 张延深 on 2020/4/13.
//  Copyright © 2020 张延深. All rights reserved.
//

#import "YSPlayerView.h"
#import "Masonry.h"
#import "UIView+GlodBuleBlockGesture.h"
#import "YSPlayerControlDelegate.h"
#import "UIImageView+GlodBuleHT.h"
#import <Accelerate/Accelerate.h>
#import "UIImage+GlodBuleResize.h"

@interface YSPlayerView ()

@property (strong, nonatomic) id<YSPlayerControlProtocol> playControl; //playControlView;
//@property (strong, nonatomic) id<YSPlayerControlDelegate> mYSPlayerControlDelegate;

@property (strong, nonatomic) UIImageView *videoBgImageView;
@property (strong, nonatomic) UIImageView *thumbImageView;
@property (strong, nonatomic) UIButton *thumbPlayBtn;
@end

@implementation YSPlayerView

//- (instancetype)initWithFrame:(CGRect)frame {
//    if (self = [super initWithFrame:frame]) {
//        [self setupUI];
//    }
//    return self;
//}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}

-(void) setThumbWithUrl:(NSString *)url
{
    if (!url || [url isEqualToString:@""]) {
        return;
    }
    [self.thumbImageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil];
    
//    [self.videoBgImageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil];
}

-(void) setBgImage:(UIImage *)mUIImage videoWidth:(CGFloat) w videoHeight:(CGFloat)h{
    if (mUIImage) {
        
//       CGFloat centeryY = mUIImage.size.height * mUIImage.scale / 2;
//        CGFloat centeryX = mUIImage.size.width * mUIImage.scale / 2;
//
//        xWidth = mUIImage.size.height;
//        CGFloat xWidth = w / h * mUIImage.size.height;
//
//        UIImage *clipUIImage = [mUIImage clipImageInRect:CGRectMake(centeryX - (xWidth/2), 0, xWidth, mUIImage.size.height)];
       
//        UIImage *resizeUIImage = [mUIImage resizedImage:CGSizeMake(500, 500) interpolationQuality:(kCGInterpolationLow)];
//
//        UIImage *resizeUIImage = [mUIImage scaleToSize:self.videoBgImageView.layer.frame.size];
        
//        UIImage *xUIImage = [self boxblurImage:resizeUIImage withBlurNumber:1];
//        [self.videoBgImageView setImage:clipUIImage];
    }
    
}

#pragma mark - Private methods

- (void)setupUI {
 
    self.backgroundColor = UIColor.brownColor;
    
    self.videoBgImageView = [[UIImageView alloc] init];
    self.videoBgImageView.contentMode =  UIViewContentModeScaleAspectFill;
    self.videoBgImageView.backgroundColor = [UIColor redColor];
    self.videoBgImageView.clipsToBounds = YES;
    self.videoBgImageView.alpha = 0.7;
    [self addSubview:self.videoBgImageView];
    [self.videoBgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.top.bottom.equalTo(self);
    }];
   
    self.thumbView = [[UIView alloc] init];
    [self addSubview:self.thumbView];
    [self.thumbView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.top.bottom.equalTo(self);
    }];
    
    self.thumbImageView = [[UIImageView alloc] init];
    self.thumbImageView.contentMode =  UIViewContentModeScaleAspectFit;
    [self.thumbView addSubview:self.thumbImageView];
    [self.thumbImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.top.bottom.equalTo(self.thumbView);
    }];
    
    /**
    self.thumbPlayImageView = [[UIImageView alloc] init];
    self.thumbPlayImageView.contentMode =  UIViewContentModeScaleAspectFill;
    self.thumbPlayImageView.userInteractionEnabled = YES;
    [self.thumbPlayImageView setImage:[UIImage imageNamed:@"play_Image"]];
    kWeakSelf
    [self.thumbPlayImageView addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        //开始播放
        [weakSelf.thumbView removeFromSuperview];//删除封面图片
        [weakSelf playControlView];
        if (weakSelf.mYSPlayerControlDelegate) {
            [weakSelf.mYSPlayerControlDelegate initPlayAndPrepareToPlay];
        }
    }];
    
    [self.thumbView addSubview:self.thumbPlayImageView];
    [self.thumbPlayImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(50);
        make.center.mas_equalTo(self);
    }];
     */
    
    [self.thumbView addSubview:self.thumbPlayBtn];
    [self.thumbPlayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(50);
        make.center.mas_equalTo(self.thumbView);
    }];
}

- (UIButton *)thumbPlayBtn {
    if (!_thumbPlayBtn) {
        _thumbPlayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        //_downloadButton.frame = CGRectMake(SCREEN_WIDTH - 100, 0, HeightForTopView, HeightForTopView);
        [_thumbPlayBtn setImage:[UIImage imageNamed:@"play_Image"] forState:UIControlStateNormal];
        [_thumbPlayBtn addTarget:self action:@selector(thumbPlayBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _thumbPlayBtn;
}

-(id<YSPlayerControlProtocol>)playControl
{
    if (!_playControl) {
        _playControl = [[NSBundle mainBundle] loadNibNamed:@"YSPlayerControl" owner:nil options:nil][0];
    }
    return _playControl;
    
}

-(void)thumbPlayBtnClick
{
//    [self.thumbView removeFromSuperview];//删除封面图片
    
//    [self.thumbPlayBtn removeFromSuperview];
    self.thumbView.hidden = YES;
    [self addSubview:(UIView *)self.playControl];
    // 添加约束
    [(UIView *)self.playControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.top.bottom.equalTo(self);
    }];
    
    if (self.mYSPlayerControlDelegate) {
        [self.mYSPlayerControlDelegate initPlayAndPrepareToPlay];
    }
}

#pragma mark - dealloc

- (void)dealloc {
    NSLog(@"%s", __func__);
}

+(UIImage *)coreBlurImage:(UIImage *)image withBlurNumber:(CGFloat)blur
{
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *inputImage= [CIImage imageWithCGImage:image.CGImage];
    //设置filter
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [filter setValue:inputImage forKey:kCIInputImageKey]; [filter setValue:@(blur) forKey: @"inputRadius"];
    //模糊图片
    CIImage *result=[filter valueForKey:kCIOutputImageKey];
    CGImageRef outImage=[context createCGImage:result fromRect:[result extent]];
    UIImage *blurImage=[UIImage imageWithCGImage:outImage];
    CGImageRelease(outImage);
    return blurImage;
}

-(UIImage *)boxblurImage:(UIImage *)image withBlurNumber:(CGFloat)blur
 {
     if (blur < 0.f || blur > 1.f) {
        blur = 0.5f;
     }
     int boxSize = (int)(blur * 40);
     boxSize = boxSize - (boxSize % 2) + 1;
     CGImageRef img = image.CGImage;
     vImage_Buffer inBuffer, outBuffer;
     vImage_Error error;
     void *pixelBuffer;
     //从CGImage中获取数据
     CGDataProviderRef inProvider = CGImageGetDataProvider(img);
     CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
     //设置从CGImage获取对象的属性
     inBuffer.width = CGImageGetWidth(img);
     inBuffer.height = CGImageGetHeight(img);
     inBuffer.rowBytes = CGImageGetBytesPerRow(img);
     inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
     pixelBuffer = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
     if(pixelBuffer == NULL)
         NSLog(@"No pixelbuffer");
     outBuffer.data = pixelBuffer;
     outBuffer.width = CGImageGetWidth(img);
     outBuffer.height = CGImageGetHeight(img);
     outBuffer.rowBytes = CGImageGetBytesPerRow(img);
     error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
     if (error) {
           NSLog(@"error from convolution %ld", error);
     }
     CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
     CGContextRef ctx = CGBitmapContextCreate( outBuffer.data, outBuffer.width, outBuffer.height, 8, outBuffer.rowBytes, colorSpace, kCGImageAlphaNoneSkipLast);
     CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
     UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
     //clean up CGContextRelease(ctx);
     CGColorSpaceRelease(colorSpace);
     free(pixelBuffer);
     CFRelease(inBitmapData);
     CGColorSpaceRelease(colorSpace);
     CGImageRelease(imageRef);
     return returnImage;
}
@end
