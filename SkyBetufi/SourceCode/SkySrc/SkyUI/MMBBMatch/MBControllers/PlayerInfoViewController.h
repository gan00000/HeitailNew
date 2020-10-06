//
//  PlayerInfoViewController.h
//  SkyBallPlay
//
//  Created by ganyuanrong on 2020/9/23.
//  Copyright © 2020 Dean_F. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SkyBallHetiRedPPXXBJBaseViewController.h"
#import "SkyBallHetiRedHTMatchDetailsModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PlayerInfoViewController : SkyBallHetiRedPPXXBJBaseViewController

-(void)setData:(SkyBallHetiRedHTMatchDetailsModel *)model;

@end

NS_ASSUME_NONNULL_END
