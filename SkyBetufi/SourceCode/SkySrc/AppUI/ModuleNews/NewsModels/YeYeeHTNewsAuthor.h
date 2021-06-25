//
//  YeYeeHTNewsAuthor.h
//  SunFunly
//
//  Created by ganyuanrong on 2021/5/18.
//  Copyright © 2021 Dean_F. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YeYeeHTNewsAuthor : NSObject

@property (nonatomic, copy) NSString *author_id;
@property (nonatomic, copy) NSString *slug;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *first_name;
@property (nonatomic, copy) NSString *last_name;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *xdescription;
@property (nonatomic, copy) NSString *avatar;

@end

NS_ASSUME_NONNULL_END
