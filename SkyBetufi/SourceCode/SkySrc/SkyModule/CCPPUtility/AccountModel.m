//
//  AccountModel.m
//  R2DSDK
//
//  Created by ganyuanrong on 2020/7/14.
//  Copyright © 2020 ganyuanrong. All rights reserved.
//

#import "AccountModel.h"

@implementation AccountModel


- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.accountName forKey:@"accountName"];
    [aCoder encodeObject:self.accountPwd forKey:@"accountPwd"];
    [aCoder encodeObject:self.lastLoginTime forKey:@"lastLoginTimemobile"];

}


- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {

        self.accountName = [aDecoder decodeObjectForKey:@"accountName"];
        self.accountPwd = [aDecoder decodeObjectForKey:@"accountPwd"];
        self.lastLoginTime = [aDecoder decodeObjectForKey:@"lastLoginTimemobile"];
  
    }
    
    return self;
}

@end
