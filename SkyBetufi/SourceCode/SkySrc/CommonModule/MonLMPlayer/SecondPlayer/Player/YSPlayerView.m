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

@interface YSPlayerView ()

@property (strong, nonatomic) id<YSPlayerControlProtocol> playControl; //playControlView;
//@property (strong, nonatomic) id<YSPlayerControlDelegate> mYSPlayerControlDelegate;

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
}

#pragma mark - Private methods

- (void)setupUI {
    self.backgroundColor = [UIColor blackColor];

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
    
    [self.thumbPlayBtn removeFromSuperview];
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

@end
