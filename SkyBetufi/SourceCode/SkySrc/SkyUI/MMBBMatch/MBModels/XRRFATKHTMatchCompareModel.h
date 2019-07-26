//
//  XRRFATKHTMatchCompareModel.h
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/10/9.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XRRFATKHTMatchDetailsModel.h"

@interface XRRFATKHTMatchCompareModel : NSObject

@property (nonatomic, strong) NSArray<XRRFATKHTMatchDetailsModel *> *homeTeamDetails;
@property (nonatomic, strong) NSArray<XRRFATKHTMatchDetailsModel *> *awayTeamDetails;


@end
