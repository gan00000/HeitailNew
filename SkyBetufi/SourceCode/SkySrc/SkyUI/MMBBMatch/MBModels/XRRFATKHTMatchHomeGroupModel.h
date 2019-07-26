//
//  XRRFATKHTMatchHomeGroupModel.h
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/9/9.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XRRFATKHTMatchHomeModel.h"

@interface XRRFATKHTMatchHomeGroupModel : NSObject

@property (nonatomic, copy) NSString *groupName;
@property (nonatomic, strong) NSArray <XRRFATKHTMatchHomeModel *> *matchList;

@end
