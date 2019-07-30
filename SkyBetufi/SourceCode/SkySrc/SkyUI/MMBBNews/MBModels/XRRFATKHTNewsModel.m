#import "XRRFATKHTNewsModel.h"
#import "XRRFATKBJDateFormatUtility.h"
#import "XRRFATKBJHTTPServiceEngine.h"
#import "XRRFATKHTHtmlLoadUtil.h"
#import <UMShare/UMShare.h>
#import <SDWebImage/SDWebImageManager.h>
#import "XRRFATKPPXXBJViewControllerCenter.h"
#import "XRRFATKHTLoginAlertView.h"
@interface XRRFATKHTNewsModel () <NSURLConnectionDelegate>
@property (nonatomic, copy) NSString *clearContent;
@end
@implementation XRRFATKHTNewsModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"news_id": @"id"
             };
}
- (void)setContent:(NSString *)content {
    _content = content;
    NSString *firstImg = [[RX(@"<img(.*?)src=\"(.*?)\"") matches:content] firstObject];
    if (firstImg) {
        _img_url = [[[firstImg componentsSeparatedByString:@"src=\""] lastObject] stringByReplacingOccurrencesOfString:@"\"" withString:@""];
        _share_thub = [UIImage imageNamed:@"image_app_icon"];
        if (_img_url.length > 0) {
            _share_thub = _img_url;
        }
    }
    NSString *iframe = [[RX(@"<iframe(.*?)</iframe>") matches:content] firstObject];
    _news_type = @"新聞";
    if (iframe) {
        _news_type = @"影片";
        NSInteger width = 0;
        NSString *widthStr = [[RX(@"width\\s*=\\s*\"(.*?)\"|width\\s*:\\s*\\d+") matches:iframe] firstObject];
        if (widthStr) {
            width = [[[RX(@"\\d+") matches:widthStr] firstObject] integerValue];
        }
        NSInteger height = 0;
        NSString *heightStr = [[RX(@"height\\s*=\\s*\"(.*?)\"|height\\s*:\\s*\\d+") matches:iframe] firstObject];
        if (heightStr) {
            height = [[[RX(@"\\d+") matches:heightStr] firstObject] integerValue];
        }
        if (height == 0 || width == 0) {
            height = 2;
            width = 3;
        }
        CGFloat ifram_width = SCREEN_WIDTH - 30;
        _iframe_height = ifram_width * height / width;
        CGFloat titleHeiht = [self.title jx_sizeWithFont:[UIFont systemFontOfSize:14] constrainedToWidth:ifram_width].height;
        _filmCellHeight = _iframe_height + titleHeiht + 75;
        NSString *newWidhtStr = [RX(@"\\d+") stringByReplacingMatchesInString:widthStr options:kNilOptions range:NSMakeRange(0, widthStr.length) withTemplate:[NSString stringWithFormat:@"%ld", (NSInteger)ifram_width]];
        NSString *newHeightStr = [RX(@"\\d+") stringByReplacingMatchesInString:heightStr options:kNilOptions range:NSMakeRange(0, heightStr.length) withTemplate:[NSString stringWithFormat:@"%ld", (NSInteger)_iframe_height]];
        iframe = [iframe stringByReplacingOccurrencesOfString:widthStr
                                                   withString:newWidhtStr];
        iframe = [iframe stringByReplacingOccurrencesOfString:heightStr
                                                   withString:newHeightStr];
        NSLog(@"iframe = %@", iframe);
        _iframe = [[XRRFATKHTHtmlLoadUtil sharedInstance] iframHtmlWithContent:iframe];
        NSLog(@"iframe = %@", _iframe);
    } 
}
- (void)setDate:(NSString *)date {
    _date = date;
    _time = [XRRFATKBJDateFormatUtility dateToShowFromDateString:date];
}
- (void)setCustom_fields:(NSDictionary *)custom_fields {
    _custom_fields = custom_fields;
    NSInteger sum = 1000;
    NSArray *views = custom_fields[@"views"];
    for (NSString *view in views) {
        sum += view.integerValue;
    }
    _view_count = [NSString stringWithFormat:@"%ld", sum];
}
- (void)setTitle:(NSString *)title {
    _title = title;
    CGFloat titleHeight = [title jx_sizeWithFont:[UIFont systemFontOfSize:17 weight:UIFontWeightMedium] constrainedToWidth:SCREEN_WIDTH-30].height;
    _detailHeaderHeight = titleHeight + 70;
}
- (void)skarggetClearContentWithBlock:(void(^)(BOOL success, NSString *content))block {
    if (!block) {
        return;
    }
    
    if (self.clearContent) {
        block(YES, self.clearContent);
    }
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURL *url = [NSURL URLWithString:self.url];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"GET";
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            block(NO, nil);
            return;
        }
        
        NSString *html = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        html = [html stringByReplacingOccurrencesOfString:@"class=\"onelist\""
                                               withString:@" style=\" display: none\""];
        
        html = [html stringByReplacingOccurrencesOfString:@"class=\"next-prev-posts clearfix\""
                                               withString:@" style=\" display: none\""];
        
        html = [html stringByReplacingOccurrencesOfString:@"id=\"footer\""
                                               withString:@" style=\" display: none\""];
        
        html = [html stringByReplacingOccurrencesOfString:@"id=\"header\""
                                               withString:@" style=\" display: none\""];
        
        html = [html stringByReplacingOccurrencesOfString:@"class=\"sidebar sidebar-right\""
                                               withString:@" style=\" display: none\""];
        
        html = [html stringByReplacingOccurrencesOfString:@"//pagead2.googlesyndication.com/pagead/js/adsbygoogle.js"
                                               withString:@"#"];
        
        html = [html stringByReplacingOccurrencesOfString:@"class=\"heateorSssSharingRound\""
                                               withString:@" style=\" display: none\""];
        
        html = [html stringByReplacingOccurrencesOfString:@"class=\"adsbygoogle\""
                                               withString:@" style=\" display: none\""];
        
        html = [html stringByReplacingOccurrencesOfString:@"class=\"to-top\""
                                               withString:@" style=\" display: none\""];
        
        html = [html stringByReplacingOccurrencesOfString:@"class=\"post_icon\""
                                               withString:@" style=\" display: none\""];
        
        html = [html stringByReplacingOccurrencesOfString:@"class=\"post-content\""
                                               withString:@"class=\"post-content app-hidden-ads\""];
        
        html = [html stringByReplacingOccurrencesOfString:@"class=\"post-entry-categories\""
                                               withString:@" style=\" display: none\""];
        
        html = [html stringByReplacingOccurrencesOfString:@"class=\"post-title\""
                                               withString:@" style=\" display: none\""];
        
        html = [html stringByReplacingOccurrencesOfString:@"id=\"recommendedrPosts\""
                                               withString:@"id=\"recommendedrPostsApps\""];
        
        html = [html stringByReplacingOccurrencesOfString:@"plugins/wp-polls"
                                               withString:@"#"];
        
        html = [html stringByReplacingOccurrencesOfString:@"plugins/popups"
                                               withString:@"#"];
        
        html = [html stringByReplacingOccurrencesOfString:@"plugins/adrotate"
                                               withString:@"#"];
        
        html = [html stringByReplacingOccurrencesOfString:@"content-cjtz-mini"
                                               withString:@"app_ad_hidden"];
        
        self.clearContent = html;
        dispatch_async(dispatch_get_main_queue(), ^{
            block(YES, self.clearContent);
        });
    }];
    [task resume];
}
+ (BOOL)skargcanShare {
    return YES;
}
- (void)skargshare {
    kWeakSelf
    [XRRFATKHTLoginAlertView skargshowShareAlertViewWithSelectBlock:^(HTLoginPlatform platform) {
        UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
        if (platform == HTLoginPlatformFB) {
            UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:weakSelf.title descr:nil thumImage:weakSelf.share_thub];
            shareObject.webpageUrl = weakSelf.url;
            messageObject.shareObject = shareObject;
            [self doShareToPlatform:UMSocialPlatformType_Facebook withMessage:messageObject];
        } else if (platform == HTLoginPlatformLine) {
            if (![[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_Line]) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://line.me/R/"]];
                return;
            }
            messageObject.text = [NSString stringWithFormat:@"%@\n链接：%@", weakSelf.title, weakSelf.url];
            if (weakSelf.img_url) {
                [XRRFATKBJLoadingHud showHUDInView:[XRRFATKPPXXBJViewControllerCenter currentViewController].view];
                [[SDWebImageManager sharedManager] loadImageWithURL:[NSURL URLWithString:weakSelf.img_url] options:0 progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
                    if (image) {
                        UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
                        [shareObject setShareImage:image];
                        messageObject.shareObject = shareObject;
                        [weakSelf doShareToPlatform:UMSocialPlatformType_Line withMessage:messageObject];
                    } else {
                        [weakSelf doShareToPlatform:UMSocialPlatformType_Line withMessage:messageObject];
                    }
                    [XRRFATKBJLoadingHud hideHUDInView:[XRRFATKPPXXBJViewControllerCenter currentViewController].view];
                }];
            } else {
                [weakSelf doShareToPlatform:UMSocialPlatformType_Line withMessage:messageObject];
            }
        }
    }];
}
- (void)doShareToPlatform:(UMSocialPlatformType)platformType withMessage:(UMSocialMessageObject *)messageObject {
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:[XRRFATKPPXXBJViewControllerCenter currentViewController] completion:^(id result, NSError *error) {
        BJLog(@"result = %@", error);
    }];
}
- (XRRFATKHTUserInfoModel *)userInfo {
    if (!_userInfo) {
        _userInfo = [[XRRFATKHTUserInfoModel alloc] init];
        _userInfo.user_img = self.user_img;
    }
    return _userInfo;
}
- (NSDate *)comt_date_obj {
    if (!_comt_date_obj) {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        _comt_date_obj = [format dateFromString:self.comment_date];
    }
    return _comt_date_obj;
}
- (void)skargcountCommentHeight {
    CGFloat commetheight = [self.comment_content jx_sizeWithFont:[UIFont systemFontOfSize:15] constrainedToWidth:SCREEN_WIDTH-71].height;
    self.my_comment_cell_height = commetheight + 118;
}
@end
