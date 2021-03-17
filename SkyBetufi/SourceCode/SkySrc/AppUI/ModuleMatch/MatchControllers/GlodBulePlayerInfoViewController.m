//
//  GlodBulePlayerInfoViewController.m
//  SkyBallPlay
//
//  Created by ganyuanrong on 2020/9/23.
//  Copyright © 2020 Dean_F. All rights reserved.
//

#import "GlodBulePlayerInfoViewController.h"
#import "UIImageView+GlodBuleHT.h"
#import "GlodBuleHTMatchSummaryRequest.h"
#import "GlodBuleHTLoginAlertView.h"
#import <UMShare/UMShare.h>
#import <FBSDKShareKit/FBSDKShareKit.h>

@interface GlodBulePlayerInfoViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *playerNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *teamLabel;
@property (weak, nonatomic) IBOutlet HMSegmentedControl *segmentControl;

@property (nonatomic) GlodBuleHTMatchDetailsModel *model_1;
@property (nonatomic) GlodBuleHTMatchDetailsModel *model_2;
@property (nonatomic) GlodBuleHTMatchDetailsModel *model_3;
@property (nonatomic) GlodBuleHTMatchDetailsModel *model_4;

@property (nonatomic) GlodBuleHTMatchDetailsModel *model_all;

@property(weak,nonatomic) GlodBuleHTMatchDetailsModel *model;

@property (weak, nonatomic) IBOutlet UILabel *scoreLable;
@property (weak, nonatomic) IBOutlet UILabel *assLabel;
@property (weak, nonatomic) IBOutlet UILabel *rebLabel;
@property (weak, nonatomic) IBOutlet UILabel *shotLabel;
@property (weak, nonatomic) IBOutlet UILabel *score3Label;
@property (weak, nonatomic) IBOutlet UILabel *faqiuLabel;
@property (weak, nonatomic) IBOutlet UILabel *qianbanLabel;
@property (weak, nonatomic) IBOutlet UILabel *houbanLabel;
@property (weak, nonatomic) IBOutlet UILabel *fanguiLabel;
@property (weak, nonatomic) IBOutlet UILabel *chaojieLabel;
@property (weak, nonatomic) IBOutlet UILabel *shiwuLabel;
@property (weak, nonatomic) IBOutlet UILabel *fenggaiLabel;

@property (weak, nonatomic) IBOutlet UILabel *desInfoLabel;

@property (weak, nonatomic) IBOutlet UIScrollView *mScrollView;
@property (weak, nonatomic) IBOutlet UIView *mContentView;

@end

@implementation GlodBulePlayerInfoViewController

+ (instancetype)taoviewController {
    return kLoadStoryboardWithName(@"PlayerInfo");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"數據卡";
    NSLog(@"GlodBulePlayerInfoViewController viewDidLoad");
    
    self.mScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 900);
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"nav_icon_share"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] style:UIBarButtonItemStylePlain target:self action:@selector(onShareButtonTapped:)];
    
    [self initSegmentControl];
    
    self.model_all = [[GlodBuleHTMatchDetailsModel alloc] init];
    
    [kWindow showLoadingView];
    [GlodBuleHTMatchSummaryRequest requestPlayerInfo:self.model.gameId teamId:self.model.teamId playerId:self.model.playerId successBlock:^(NSArray<GlodBuleHTMatchDetailsModel *> *model) {
        
        [kWindow hideLoadingView];
        //計算全場數據
        int pts = 0, ast = 0, reb = 0, fgmade = 0,fgatt = 0,fg3ptmade = 0,fg3ptatt = 0,ftmade = 0,ftatt = 0,offreb = 0,defreb = 0,fouls=0,stl = 0,blkagainst = 0,blk = 0;
        for (GlodBuleHTMatchDetailsModel *xm in model) {
            if ([xm.quarter isEqualToString:@"1"]) {
                self.model_1 = xm;
            }else  if ([xm.quarter isEqualToString:@"2"]) {
                self.model_2 = xm;
            }else  if ([xm.quarter isEqualToString:@"3"]) {
                self.model_3 = xm;
            }else  if ([xm.quarter isEqualToString:@"4"]) {
                self.model_4 = xm;
            }
            
            pts += [xm.pts intValue];
            ast += [xm.ast intValue];
            reb += [xm.reb intValue];
            fgmade += [xm.fgmade intValue];
            fgatt += [xm.fgatt intValue];
            fg3ptmade += [xm.fg3ptmade intValue];
            fg3ptatt += [xm.fg3ptatt intValue];
            ftmade += [xm.ftmade intValue];
            ftatt += [xm.ftatt intValue];
            offreb += [xm.offreb intValue];
            defreb += [xm.defreb intValue];
            fouls += [xm.fouls intValue];
            stl += [xm.stl intValue];
            blkagainst += [xm.blkagainst intValue];
            blk += [xm.blk intValue];
            
            self.model_all.pts = [NSString stringWithFormat:@"%d",pts];
            self.model_all.ast = [NSString stringWithFormat:@"%d",ast];
            self.model_all.reb = [NSString stringWithFormat:@"%d",reb];
            self.model_all.fgmade = [NSString stringWithFormat:@"%d",fgmade];
            self.model_all.fgatt = [NSString stringWithFormat:@"%d",fgatt];
            self.model_all.fg3ptmade = [NSString stringWithFormat:@"%d",fg3ptmade];
            self.model_all.fg3ptatt = [NSString stringWithFormat:@"%d",fg3ptatt];
            self.model_all.ftmade = [NSString stringWithFormat:@"%d",ftmade];
            self.model_all.ftatt = [NSString stringWithFormat:@"%d",ftatt];
            self.model_all.offreb = [NSString stringWithFormat:@"%d",offreb];
            self.model_all.defreb = [NSString stringWithFormat:@"%d",defreb];
            self.model_all.fouls = [NSString stringWithFormat:@"%d",fouls];
            self.model_all.stl = [NSString stringWithFormat:@"%d",stl];
            self.model_all.blkagainst = [NSString stringWithFormat:@"%d",blkagainst];
            self.model_all.blk = [NSString stringWithFormat:@"%d",blk];
         
        }
        
        self.segmentControl.selectedSegmentIndex = 4;
        [self setPlayerData:self.model_all];
        
    } errorBlock:^(GlodBuleBJError *error) {
        [kWindow showToast:@"獲取數據出錯"];
    }];
    
    
    
    GlodBuleHTMatchSummaryModel *matchSummaryModel = [GlodBuleHTUserManager manager].matchSummaryModel;
    if (matchSummaryModel) {
        
        NSString *status = @"";
        if ([matchSummaryModel.scheduleStatus isEqualToString:@"Final"]) {
            status = @"已結束";
            
        } else if ([matchSummaryModel.scheduleStatus isEqualToString:@"InProgress"]) {
            status = @"進行中";
        } else if ([matchSummaryModel.scheduleStatus isEqualToString:@"Canceled"]) {
            status = @"已取消";
        } else  {
            status = @"未開始";
    
        }
//        self.desInfoLabel.textAlignment = NSTextAlignmentRight|NSTextAlig
        self.desInfoLabel.text = [NSString stringWithFormat:@"%@\n%@\n %@%@ - %@%@", matchSummaryModel.date, status, matchSummaryModel.homeName,matchSummaryModel.home_pts, matchSummaryModel.away_pts,matchSummaryModel.awayName];
        
        
        self.playerNameLabel.text = self.model.name;
        if ([self.model.teamId isEqualToString:matchSummaryModel.homeTeam]) {
            self.teamLabel.text = [NSString stringWithFormat:@"%@ %@號", matchSummaryModel.homeName, self.model.jerseynumber];
        }else{
            self.teamLabel.text = [NSString stringWithFormat:@"%@ %@號", matchSummaryModel.awayName, self.model.jerseynumber];
        }
        
        
        [self.iconImageView th_setImageWithURL:self.model.officialImagesrc placeholderImage:HT_DEFAULT_AVATAR_LOGO];
     
    }
}


- (void)initSegmentControl {
    if (_segmentControl) {
        //_segmentControl = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"客隊", @"主隊"]];
        _segmentControl.sectionTitles = @[@"1ST", @"2ND", @"3RD", @"4TH", @"全場"];
        _segmentControl.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"fafafa"];
        _segmentControl.selectionIndicatorColor = [UIColor hx_colorWithHexRGBAString:@"4E8BFF"];
        _segmentControl.selectionIndicatorHeight = 3.0f;
        _segmentControl.selectionIndicatorEdgeInsets = UIEdgeInsetsMake(0, -8, 0, -18);
        _segmentControl.titleTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:15 weight:UIFontWeightMedium],
                                                NSForegroundColorAttributeName:[UIColor hx_colorWithHexRGBAString:@"666666"]};
        _segmentControl.selectedTitleTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:15 weight:UIFontWeightMedium],
                                                        NSForegroundColorAttributeName:[UIColor hx_colorWithHexRGBAString:@"4E8BFF"]};
        _segmentControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
        _segmentControl.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
        kWeakSelf
        _segmentControl.indexChangeBlock = ^(NSInteger index){
            [weakSelf segmentedValueChangedHandle:index];
        };
        _segmentControl.selectedSegmentIndex = 4;
    }
   // return _segmentControl;
}

#pragma mark -- HMSegmentedControl Action
- (void)segmentedValueChangedHandle:(NSInteger)index {
    BJLog(@"segmentedValueChangedHandle=%d", index);
    //self.currentIndex = index;
    //[self loadChildViewControllerByIndex:index];
   // [self.containerView setContentOffset:CGPointMake(index * SCREEN_WIDTH, 0) animated:YES];
    
    if (index == 0) {
        [self setPlayerData:self.model_1];
    }else if(index == 1) {
        [self setPlayerData:self.model_2];
    }else if(index == 2) {
        [self setPlayerData:self.model_3];
    }else if(index == 3) {
        [self setPlayerData:self.model_4];
    }else if(index == 4) {
        [self setPlayerData:self.model_all];
    }
    
}

-(void)setPlayerData:(GlodBuleHTMatchDetailsModel *)model
{
    self.scoreLable.text = @"0";
    self.assLabel.text = @"0";
    self.rebLabel.text = @"0";
    self.shotLabel.text = @"0 - 0";//[NSString stringWithFormat:@"%@ - %@",model.fgmade,model.fgatt];
    
    self.score3Label.text = @"0 - 0";;//[NSString stringWithFormat:@"%@ - %@",model.fg3ptmade,model.fg3ptatt];
    self.faqiuLabel.text = @"0 - 0";//[NSString stringWithFormat:@"%@ - %@",model.ftmade,model.ftatt];
    
    self.qianbanLabel.text = @"0";
    self.houbanLabel.text = @"0";
    
    self.fanguiLabel.text = @"0";
    self.chaojieLabel.text = @"0";
    self.shiwuLabel.text = @"0";
    self.fenggaiLabel.text = @"0";
    
    if (model) {
        self.scoreLable.text = model.pts;
        self.assLabel.text = model.ast;
        self.rebLabel.text = model.reb;
        self.shotLabel.text = model.fgmade_show;//[NSString stringWithFormat:@"%@ - %@",model.fgmade,model.fgatt];
        
        self.score3Label.text = model.fg3ptmade_show;//[NSString stringWithFormat:@"%@ - %@",model.fg3ptmade,model.fg3ptatt];
        self.faqiuLabel.text = model.ftmade_show;//[NSString stringWithFormat:@"%@ - %@",model.ftmade,model.ftatt];
        
        self.qianbanLabel.text = model.offreb;
        self.houbanLabel.text = model.defreb;
        
        self.fanguiLabel.text = model.fouls;
        self.chaojieLabel.text = model.stl;
        self.shiwuLabel.text = model.blkagainst;
        self.fenggaiLabel.text = model.blk;
        
    }
}
- (void)dealloc {
    NSLog(@"%@ dealloc", NSStringFromClass(self.class));
}

-(void)setData:(GlodBuleHTMatchDetailsModel *)model{
    NSLog(@"GlodBulePlayerInfoViewController data");
    self.model = model;
    
//    GlodBuleHTMatchSummaryModel *matchSummaryModel = [GlodBuleHTUserManager manager].matchSummaryModel;
//    if ([self.model.teamId isEqualToString:matchSummaryModel.homeTeam]) {
//        self.teamLabel.text = [NSString stringWithFormat:@"%@ %@", matchSummaryModel.homeName, self.model.jerseynumber];
//    }else{
//        self.teamLabel.text = [NSString stringWithFormat:@"%@ %@", matchSummaryModel.awayName, self.model.jerseynumber];
//    }
}


- (void)share {
    kWeakSelf
    [GlodBuleHTLoginAlertView taoshowShareAlertViewWithFB:^(HTLoginPlatform platform) {
//        UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
        if (platform == HTLoginPlatformFB) {
            
            UIImage *image = [self makeImageWithView:self.mContentView withSize: CGSizeMake(SCREEN_WIDTH, 900)];
            if (image) {
                FBSDKSharePhoto *photo = [[FBSDKSharePhoto alloc] init];
                  photo.image = image;
                  photo.userGenerated = YES;
                  FBSDKSharePhotoContent *content = [[FBSDKSharePhotoContent alloc] init];
                  content.photos = @[photo];
                
                [FBSDKShareDialog showFromViewController:self
                                              withContent:content
                                                 delegate:nil];
            }
            
            
            
        } else if (platform == HTLoginPlatformLine) {

        }

    }];
    

}



- (void)doShareToPlatform:(UMSocialPlatformType)platformType withMessage:(UMSocialMessageObject *)messageObject {
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:[GlodBulePPXXBJViewControllerCenter currentViewController] completion:^(id result, NSError *error) {
        BJLog(@"result = %@", error);
    }];
}

#pragma mark 生成image
- (UIImage *)makeImageWithView:(UIView *)view withSize:(CGSize)size
{
    
    // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了，关键就是第三个参数 [UIScreen mainScreen].scale。
    UIGraphicsBeginImageContextWithOptions(size, YES, [UIScreen mainScreen].scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
    
}

#pragma mark - actions
- (void)onShareButtonTapped:(id)sender {
    [self share];
}

@end
