//
//  UUaksHTShowUpdateInfoView.h
//  SunFunly
//
//  Created by ganyuanrong on 2021/5/20.
//  Copyright © 2021 Dean_F. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMoogHTUpdateInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface UUaksHTShowUpdateInfoView : UIView

+ (void)showWithData:(MMoogHTUpdateInfoModel *)model;

@property (nonatomic, strong) MMoogHTUpdateInfoModel *infoModel;

@end

NS_ASSUME_NONNULL_END
