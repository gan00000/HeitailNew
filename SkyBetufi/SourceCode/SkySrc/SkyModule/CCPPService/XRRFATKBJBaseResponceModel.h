//
//  XRRFATKBJBaseResponceModel.h
//  BenjiaPro
//
//  Created by 吕磊 on 2017/5/26.
//  Copyright © 2017年 Benjia. All rights reserved.
//

#import "YYModel.h"


typedef NS_ENUM(NSInteger, BJResponseCode) {
    BJResponseCodeTokenExpired = -1,
    BJResponseCodeAccountKickOut = -2,
    BJResponseCodeError1 = -100,
    BJResponseCodeOK = 0
};


/**
 *  数据返回解析基类
 */
@interface XRRFATKBJBaseResponceModel : NSObject

/**
 *	@brief	数据状态号
 */
@property (nonatomic, assign) NSInteger code;

/**
 *	@brief	提示信息
 */
@property (nonatomic, copy) NSString *msg;

//当接口有分页时，里面包含两个值, pages和total
@property (nonatomic, copy) NSDictionary *page;

@property (nonatomic, assign) unsigned int total;

- (NSInteger)pagesValueOfPage; //当有分页时，此值表示第几页
- (NSInteger)totalValueOfPage; //当有分页时，此值表示总数据量

@end

