//
//  UUaksHTIndicatorView.h
//  SkyBallPlay
//
//  Created by ganyuanrong on 2020/8/22.
//  Copyright © 2020 Dean_F. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry.h>
#import "UIColor+FFlaliHex.h"

NS_ASSUME_NONNULL_BEGIN

@interface UUaksHTIndicatorView : UIView

-(void)updateView:(float) leftValue rightValue:(float) rightValue;

@end

NS_ASSUME_NONNULL_END
