//
//  YeYeeHTNewsAuthor.m
//  SunFunly
//
//  Created by ganyuanrong on 2021/5/18.
//  Copyright © 2021 Dean_F. All rights reserved.
//

#import "YeYeeHTNewsAuthor.h"

@implementation YeYeeHTNewsAuthor

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"author_id": @"id",
             @"xdescription":@"description"
             };
}

@end
