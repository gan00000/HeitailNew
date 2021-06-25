//
//  MMoogHTCourtHotShootView.h
//  
//
//  Created by ganyuanrong on 2021/3/5.
//  Copyright © 2021 Dean_F. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BByasHotShootPointModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MMoogHTCourtHotShootView : UIView

- (void)setDataModel:(NSArray<BByasHotShootPointModel *> *) model isLeft:(BOOL) isLeft width:(CGFloat)width height:(CGFloat)height;

@end

NS_ASSUME_NONNULL_END
