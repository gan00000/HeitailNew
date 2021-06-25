//
//  WSKggHTAdViewCell.m
//  SkyBallPlay
//
//  Created by ganyuanrong on 2019/12/13.
//  Copyright © 2019 Dean_F. All rights reserved.
//

#import "WSKggHTAdViewCell.h"
@import GoogleMobileAds;

@interface WSKggHTAdViewCell ()

@property (weak, nonatomic) IBOutlet GADBannerView *thAdView;

@property (assign, nonatomic) BOOL isRequestAd;
@end

@implementation WSKggHTAdViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.isRequestAd = NO;
}

-(void) requestAd:(UIViewController *)viewController{
    
    if (self.isRequestAd) {
        return;
    }
    self.isRequestAd = YES;
    self.thAdView.adUnitID = @"ca-app-pub-4059643053601138/5503853759";
    self.thAdView.rootViewController = viewController;
//    [self.thAdView setAutoloadEnabled:YES];
    [self.thAdView loadRequest:[GADRequest request]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
