//
//  CCCaseHTNewsTextCell.m
//  
//
//  Created by ganyuanrong on 2021/4/2.
//  Copyright © 2021 Dean_F. All rights reserved.
//

#import "CCCaseHTNewsTextCell.h"
#import "KMonkeyBJUtility.h"

@implementation CCCaseHTNewsTextCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) setNewsText:(NSString *)newsText
{

    self.newsTextLabel.attributedText = [KMonkeyBJUtility getNewsTextAttribute:newsText];
    
//    2.富文本label的高度自适应
//
//     NSMutableAttributedString *str=  [[NSMutableAttributedString alloc] initWithData:[self.HTMLstring dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
//    [str addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:14] range:NSMakeRange(0, str.length)];(字体font是自定义的 要求和要显示的label设置的font一定要相同)
//    CGRect rect = [self.contentLabel.attributedText boundingRectWithSize:CGSizeMake(WIDTH - 330 *FITWIDTH, 0) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
//    self.contentLabel.frame = CGRectMake(115 *FITWIDTH, 110 *FITWIDTH, WIDTH - 330 *FITWIDTH, rect.size.height);
//    self.contentLabel.attributedText =  str;
}


@end
