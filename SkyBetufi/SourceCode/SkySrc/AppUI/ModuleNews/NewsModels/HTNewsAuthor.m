//
//  HTNewsAuthor.m
//  SunFunly
//
//  Created by ganyuanrong on 2021/5/18.
//  Copyright © 2021 Dean_F. All rights reserved.
//

#import "HTNewsAuthor.h"

@implementation HTNewsAuthor

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"author_id": @"id",
             @"xdescription":@"description"
             };
}

@end
