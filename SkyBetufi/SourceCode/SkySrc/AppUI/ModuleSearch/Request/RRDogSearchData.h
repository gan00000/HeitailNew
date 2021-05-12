//
//  RRDogSearchData.h
//  SkyBallPlay
//
//  Created by ganyuanrong on 2020/9/9.
//  Copyright © 2020 Dean_F. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RRDogSearchData : NSObject <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSArray *newsList;
@property (nonatomic) ClickHander xClickHander;
@end

NS_ASSUME_NONNULL_END
