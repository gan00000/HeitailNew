//
//  YeYeeHTShowUpdateInfoView.h
//  SunFunly
//
//  Created by ganyuanrong on 2021/5/20.
//  Copyright © 2021 Dean_F. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YeYeeHTUpdateInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface YeYeeHTShowUpdateInfoView : UIView

+ (void)showWithData:(YeYeeHTUpdateInfoModel *)model;

@property (nonatomic, strong) YeYeeHTUpdateInfoModel *infoModel;

@end

NS_ASSUME_NONNULL_END
