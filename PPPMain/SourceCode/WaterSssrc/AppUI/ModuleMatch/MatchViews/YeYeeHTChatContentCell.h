//
//  YeYeeHTChatContentCell.h
//  SkyBallPlay
//
//  Created by ganyuanrong on 2020/9/14.
//  Copyright © 2020 Dean_F. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YeYeeHTChatContentCell : UITableViewCell

@property (weak, nonatomic) IBOutlet JXLabel *chatContentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *userImage;

@property (weak, nonatomic) IBOutlet JXLabel *userNameLabel;
- (void)setChaMsg:(NSString *) msg;

@end

NS_ASSUME_NONNULL_END
