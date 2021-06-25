//
//  YeYeeHTCourtHotShootView.h
//  
//
//  Created by ganyuanrong on 2021/3/5.
//  Copyright © 2021 Dean_F. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TuTuosHotShootPointModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface YeYeeHTCourtHotShootView : UIView

- (void)setDataModel:(NSArray<TuTuosHotShootPointModel *> *) model isLeft:(BOOL) isLeft width:(CGFloat)width height:(CGFloat)height;

@end

NS_ASSUME_NONNULL_END
