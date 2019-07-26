//
//  XRRFATKHTDataHomeInfoModel.h
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/9/12.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XRRFATKHTDataHomeModel.h"

@interface XRRFATKHTDataHomeInfoModel : NSObject

/// 得分
@property (nonatomic, strong) NSArray<XRRFATKHTDataHomeModel *> *pts;
/// 籃板
@property (nonatomic, strong) NSArray<XRRFATKHTDataHomeModel *> *reb;
/// 助攻
@property (nonatomic, strong) NSArray<XRRFATKHTDataHomeModel *> *ast;
/// 搶斷
@property (nonatomic, strong) NSArray<XRRFATKHTDataHomeModel *> *stl;
/// 蓋帽
@property (nonatomic, strong) NSArray<XRRFATKHTDataHomeModel *> *blk;
/// 失誤
@property (nonatomic, strong) NSArray<XRRFATKHTDataHomeModel *> *turnover;

@end
