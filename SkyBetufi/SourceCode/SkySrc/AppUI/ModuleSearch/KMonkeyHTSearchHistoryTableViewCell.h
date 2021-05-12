//
//  KMonkeyHTSearchHistoryTableViewCell.h
//  SkyBallPlay
//
//  Created by ganyuanrong on 2020/9/7.
//  Copyright © 2020 Dean_F. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KMonkeyHTSearchHistoryTableViewCell : UITableViewCell

-(void) setHistory:(NSString *)tx;
@property(nonatomic,strong) ClickHander mClickHander;
@end

NS_ASSUME_NONNULL_END
