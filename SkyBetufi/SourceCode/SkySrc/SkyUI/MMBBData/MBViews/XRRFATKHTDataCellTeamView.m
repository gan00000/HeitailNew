//
//  XRRFATKHTDataCellTeamView.m
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/9/14.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import "XRRFATKHTDataCellTeamView.h"
#import <WebKit/WebKit.h>

@interface XRRFATKHTDataCellTeamView ()

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *teamNameLabel;

@property (nonatomic, strong) WKWebView *teamLogoWeb;
@property (nonatomic, assign) NSInteger width;


@end

@implementation XRRFATKHTDataCellTeamView

+ (instancetype)dataCellViewWithFrame:(CGRect)frame addToView:(UIView *)view {
    UIView *contentView = [[UIView alloc] initWithFrame:frame];
    XRRFATKHTDataCellTeamView *cellView = kLoadXibWithName(@"XRRFATKHTDataCellTeamView");
    cellView.frame = cellView.bounds;
    cellView.width = ceil(frame.size.width);
    [contentView addSubview:cellView];
    [view addSubview:contentView];
    
    return cellView;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self addSubview:self.teamLogoWeb];
    [self.teamLogoWeb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.imageView);
    }];
}

- (void)skargsetupWithDataModel:(XRRFATKHTDataHomeModel *)dataModel {
    self.scoreLabel.text = [NSString stringWithFormat:@"%.1f", dataModel.pts];
    self.teamNameLabel.text = dataModel.teamName;
    
    [dataModel skargimageUrlFixWithWidth:self.width-30];
    
    self.imageView.hidden = YES;
    self.teamLogoWeb.hidden = YES;
    if (dataModel.html_team_logo.length > 0) {
        self.teamLogoWeb.hidden = NO;
        [self.teamLogoWeb loadHTMLString:dataModel.html_team_logo baseURL:nil];
    } else {
        self.imageView.hidden = NO;
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:dataModel.team_logo]
                          placeholderImage:HT_DEFAULT_IMAGE];
    }
}


- (WKWebView *)teamLogoWeb {
    if (!_teamLogoWeb) {
        _teamLogoWeb = [[WKWebView alloc] init];
        _teamLogoWeb.scrollView.scrollEnabled = NO;
        _teamLogoWeb.clipsToBounds = YES;
    }
    return _teamLogoWeb;
}

@end
