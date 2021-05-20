//
//  HTShowUpdateInfoView.h
//  SunFunly
//
//  Created by ganyuanrong on 2021/5/20.
//  Copyright © 2021 Dean_F. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTUpdateInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HTShowUpdateInfoView : UIView

+ (void)showWithData:(HTUpdateInfoModel *)model;

@property (nonatomic, strong) HTUpdateInfoModel *infoModel;

@end

NS_ASSUME_NONNULL_END
