//
//  HourseHotShootPointModel.h
//  
//
//  Created by ganyuanrong on 2021/3/6.
//  Copyright © 2021 Dean_F. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HourseHotShootPointModel : NSObject

@property (nonatomic, copy) NSString *xAxis;
@property (nonatomic, copy) NSString *yAxis;
@property (nonatomic, copy) NSString *isHit;//是否命中 1-是 0-否

@end

NS_ASSUME_NONNULL_END
