//
//  HTNewsDetailModel.h
//  XXXHeiTai
//
//  Created by ganyuanrong on 2021/4/2.
//  Copyright © 2021 Dean_F. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HTNewsDetailModel : NSObject

@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *data;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat width;

@property (nonatomic, copy) NSString *poster;
@property (nonatomic, copy) NSString *length_formatted;

@end

NS_ASSUME_NONNULL_END
