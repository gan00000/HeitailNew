//
//  BlysaHTCompareView.h
//  SkyBallPlay
//
//  Created by ganyuanrong on 2020/8/23.
//  Copyright © 2020 Dean_F. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BlysaHTCompareView : UIView

-(void) updateWithLeftValue:(float)leftValue rightValue:(float) rightValue;

-(void) updateWithLeftPercent:(float)leftPercent rightPercent:(float) rightPercent;

@end

NS_ASSUME_NONNULL_END
