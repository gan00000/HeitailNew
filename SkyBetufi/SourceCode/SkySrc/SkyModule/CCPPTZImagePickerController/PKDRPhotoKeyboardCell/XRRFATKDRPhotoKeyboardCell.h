//
//  DRPhotoKeyboardPhotoCell.h
//  Records
//
//  Created by Jeason on 2017/11/6.
//  Copyright © 2017年 DuoRong Technology Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DRPhotoKeyboardDidTapDeleteBlock)(void);

@interface XRRFATKDRPhotoKeyboardCell : UICollectionViewCell

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, copy) DRPhotoKeyboardDidTapDeleteBlock deleteBlock;

- (UIView *)snapshotView;

@end
