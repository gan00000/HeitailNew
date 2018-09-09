//
//  HTNewsModel.h
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/9/9.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTNewsModel : NSObject

@property (nonatomic, copy) NSString *news_id;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *title_plain;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *img_url;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, assign) NSInteger read_count;

@end
