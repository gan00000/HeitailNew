//
//  MMTodayPlayerInfoViewController.h
//  SkyBallPlay
//
//  Created by ganyuanrong on 2020/9/23.
//  Copyright © 2020 Dean_F. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCCasePPXXBJBaseViewController.h"
#import "SundayHTMatchDetailsModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MMTodayPlayerInfoViewController : CCCasePPXXBJBaseViewController

-(void)setData:(SundayHTMatchDetailsModel *)model;

@end

NS_ASSUME_NONNULL_END
