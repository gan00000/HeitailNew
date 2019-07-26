//
//  XRRFATKTZVideoPlayerController.h
//  XRRFATKTZImagePickerController
//
//  Created by 谭真 on 16/1/5.
//  Copyright © 2016年 谭真. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XRRFATKTZVideoPlayerController;

typedef void (^TZVideoPlayerControllerDeleteBlock)();

@protocol TZVideoPlayerControllerDelegate <NSObject>
@optional
- (void)videoPlayerControllerDelectVideo:(XRRFATKTZVideoPlayerController *)videoPlayerController;

@end

@class XRRFATKTZAssetModel;
@interface XRRFATKTZVideoPlayerController : UIViewController

@property (weak, nonatomic) id<TZVideoPlayerControllerDelegate> delegate;
@property (copy, nonatomic) TZVideoPlayerControllerDeleteBlock deleteBlock;
@property (nonatomic, strong) XRRFATKTZAssetModel *model;
@property (strong, nonatomic) UIImage *coverImg;// 视频封面图
@property (copy, nonatomic) NSString *videoPath;// 视频播放地址

@end
