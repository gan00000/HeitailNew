//
//  MMoogHTNewsTextCell.h
//  
//
//  Created by ganyuanrong on 2021/4/2.
//  Copyright © 2021 Dean_F. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MMoogHTNewsTextCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *newsTextLabel;

-(void) setNewsText:(NSString *)newsText;

@end

NS_ASSUME_NONNULL_END
