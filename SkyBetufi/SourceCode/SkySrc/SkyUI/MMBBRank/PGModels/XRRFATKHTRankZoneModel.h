//
//  XRRFATKHTRankZoneModel.h
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/10/14.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XRRFATKHTRankModel.h"

@interface XRRFATKHTRankZoneModel : NSObject

/// 大西洋賽區 - 東部
@property (nonatomic, strong) NSArray<XRRFATKHTRankModel *> *EasternAtlantic;
/// 中部賽區 - 東部
@property (nonatomic, strong) NSArray<XRRFATKHTRankModel *> *EasternCentral;
/// 東南賽區 - 東部
@property (nonatomic, strong) NSArray<XRRFATKHTRankModel *> *EasternSoutheast;
/// 西南賽區 - 西部
@property (nonatomic, strong) NSArray<XRRFATKHTRankModel *> *WesternNorthwest;
/// 太平洋賽區 - 西部
@property (nonatomic, strong) NSArray<XRRFATKHTRankModel *> *WesternPacific;
/// 西北賽區 - 西部
@property (nonatomic, strong) NSArray<XRRFATKHTRankModel *> *WesternSouthwest;

@end
