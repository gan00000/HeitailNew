//
//  HTAdViewCell.m
//  SkyBallPlay
//
//  Created by ganyuanrong on 2019/12/13.
//  Copyright © 2019 Dean_F. All rights reserved.
//

#import "HTAdViewCell.h"
@import GoogleMobileAds;

@interface HTAdViewCell ()

@property (weak, nonatomic) IBOutlet GADBannerView *thAdView;


@end

@implementation HTAdViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void) requestAd:(UIViewController *)viewController{
    
    self.thAdView.adUnitID = @"ca-app-pub-4059643053601138/5503853759";
    self.thAdView.rootViewController = viewController;
    [self.thAdView loadRequest:[GADRequest request]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
