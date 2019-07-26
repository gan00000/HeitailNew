//
//  XRRFATKBJURINavigator.m
//  BenjiaPro
//
//  Created by Marco on 2017/6/26.
//  Copyright © 2017年 Benjia. All rights reserved.
//

#import "XRRFATKBJURINavigator.h"


//#define URI_HOME_PATH                @"zglc://home"
//#define URI_INVESTMENT_PATH          @"zglc://investment"
//#define URI_DISCOVERY_PATH           @"zglc://discovery"
//#define URI_ME_PATH                  @"zglc://me"
//
//#define URI_REGULAR_DETAIL           @"zglc://investment/r_detail?id=%@" //定期标的详情
//#define URI_FREE_DETAIL              @"zglc://investment/f_detail?product_id=%@" //活期详情
//#define URI_REGULAR_INVEST           @"zglc://investment/r_invest?id=%@" //定期投资页
//#define URI_FREE_INVEST              @"zglc://investment/f_invest?product_id=%@" //活期投资页
//
//#define URI_RECHARGE                 @"zglc://investment/recharge"
//#define URI_WITHDRAW                 @"zglc://investment/withdraw"
//
//#define URI_ME_REGULAR               @"zglc://me/regular"
//#define URI_ME_FEEDBACK              @"zglc://me/feedback"
//#define URI_ME_COUPON                @"zglc://me/coupon"
//#define URI_ME_YZB                   @"zglc://me/yzb"
//#define URI_ME_WX_NOTICE             @"zglc://me/wechat_notice"
//
//#define URI_SETTING                  @"zglc://setting"
//#define URI_BIND_PHONE               @"zglc://setting/bind_phone"
//#define URI_BIND_EMAIL               @"zglc://setting/bind_email"
//#define URI_SETTING_BANKCARD         @"zglc://setting/bankcard"
//
//#define URI_LOGIN                    @"zglc://login"
//#define URI_LOGIN_LOGIN              @"zglc://login/login"
//#define URI_LOGIN_REGISTER           @"zglc://login/register"
//
//#define URI_MESSAGE                  @"zglc://message?type=%@"
//
//#define URI_INNER_URL                @"zglc://openurl?url=%@" //从应用外跳转进来(如微信)需要打开网页的情况

typedef void (^BJURIHandlerBlock)(NSString *uri, NSString *baseUrl, NSDictionary *parms);

@interface XRRFATKBJURINavigator ()

@property (nonatomic, strong) NSMutableDictionary *uriHandlerDict;

@end

@implementation XRRFATKBJURINavigator

+ (instancetype)sharedInstance {
    static XRRFATKBJURINavigator *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[XRRFATKBJURINavigator alloc] init];
        [instance registerAll];
    });
    return instance;
}

- (BOOL)canHandleURI:(NSString *)uri {
    NSString *key = uri;
    if ([uri containsString:@"?"]) {
        key = [uri componentsSeparatedByString:@"?"][0];
    }
    if (self.uriHandlerDict[key]) {
        return YES;
    }
    return NO;
}

- (BOOL)handleURI:(NSString *)uri {
    
    BOOL hasParams = NO;
    NSString *key = uri;
    if ([uri containsString:@"?"]) {
        hasParams = YES;
        key = [uri componentsSeparatedByString:@"?"][0];
    }
    if (self.uriHandlerDict[key]) {
        
        NSMutableDictionary *parms = [NSMutableDictionary dictionary];
        if (hasParams) {
            NSURLComponents *components = [NSURLComponents componentsWithString:uri];
            for(NSURLQueryItem *item in components.queryItems) {
                parms[item.name] = item.value;
            }
        }
        
        BJURIHandlerBlock block = self.uriHandlerDict[key];
        block(uri, key, parms);
        return YES;
    }
    //test
    //[[BJViewControllerCenter currentViewController].navigationController popToRootViewControllerAnimated:YES];
    //[BJViewControllerCenter mainViewController].selectedIndex = 0;
    
    return NO;
}

- (void)registerURI:(NSString *)uri handleBlock:(BJURIHandlerBlock)handleBlock {
    NSString *key = uri;
    if ([uri containsString:@"?"]) { //uri带参数
        key = [uri componentsSeparatedByString:@"?"][0]; //key不带参数
    }
    self.uriHandlerDict[key] = handleBlock;
}

#pragma mark -
- (NSMutableDictionary *)uriHandlerDict {
    if (!_uriHandlerDict) {
        _uriHandlerDict = [[NSMutableDictionary alloc] init];
    }
    return _uriHandlerDict;
}

#pragma mark - 
- (void)registerAll {
    //__weak typeof(self)weakSelf = self;
    
//    [self registerURI:URI_INNER_URL handleBlock:^(NSString *uri, NSString *baseUrl, NSDictionary *parms) {
//        XRRFATKBJWebViewController *webVC = [[XRRFATKBJWebViewController alloc] initWithAddress:parms[@"url"]];
//        [[BJViewControllerCenter currentViewController].navigationController pushViewController:webVC animated:YES];
//    }];
//
//    //首页
//    [self registerURI:URI_HOME_PATH handleBlock:^(NSString *uri, NSString *baseUrl, NSDictionary *parms) {
//        [[BJViewControllerCenter currentViewController].navigationController popToRootViewControllerAnimated:NO];
//        //dispatch_after执行，不然webviewController的viewDidDisappear方法不执行
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [BJViewControllerCenter mainViewController].selectedIndex = BJMainTabHome;
//        });
//    }];
//    [self registerURI:URI_INVESTMENT_PATH handleBlock:^(NSString *uri, NSString *baseUrl, NSDictionary *parms) {
//        [[BJViewControllerCenter currentViewController].navigationController popToRootViewControllerAnimated:NO];
//        //dispatch_after执行，不然webviewController的viewDidDisappear方法不执行
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [BJViewControllerCenter mainViewController].selectedIndex = BJMainTabInvestment;
//        });
//    }];
//    [self registerURI:URI_DISCOVERY_PATH handleBlock:^(NSString *uri, NSString *baseUrl, NSDictionary *parms) {
//        [[BJViewControllerCenter currentViewController].navigationController popToRootViewControllerAnimated:NO];
//        //dispatch_after执行，不然webviewController的viewDidDisappear方法不执行
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [BJViewControllerCenter mainViewController].selectedIndex = BJMainTabDiscovery;
//        });
//    }];
//    [self registerURI:URI_ME_PATH handleBlock:^(NSString *uri, NSString *baseUrl, NSDictionary *parms) {
//        [[BJViewControllerCenter currentViewController].navigationController popToRootViewControllerAnimated:NO];
//        //dispatch_after执行，不然webviewController的viewDidDisappear方法不执行
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [BJViewControllerCenter mainViewController].selectedIndex = BJMainTabMe;
//        });
//    }];
//
//    //定期详情
//    [self registerURI:URI_REGULAR_DETAIL handleBlock:^(NSString *uri, NSString *baseUrl, NSDictionary *parms) {
//        BJBidDetailViewController2 *bidDetailVC = [[BJBidDetailViewController2 alloc] initWithIdentity:[parms[@"id"] integerValue]];
//        [[BJViewControllerCenter currentViewController].navigationController pushViewController:bidDetailVC animated:YES];
//    }];
//
//    //活期详情
//    [self registerURI:URI_FREE_DETAIL handleBlock:^(NSString *uri, NSString *baseUrl, NSDictionary *parms) {
//        BJHuoQiDetailViewController *huoqiDetailVC = [[BJHuoQiDetailViewController alloc] initWithProductId:[parms[@"product_id"] integerValue]];
//        [[BJViewControllerCenter currentViewController].navigationController pushViewController:huoqiDetailVC animated:YES];
//    }];
//
//    //定期投资
//    [self registerURI:URI_REGULAR_INVEST handleBlock:^(NSString *uri, NSString *baseUrl, NSDictionary *parms) {
//        BJRegularInvestViewController *investVC = [[BJRegularInvestViewController alloc] initWithBidId:[parms[@"id"] integerValue]];
//        [[BJViewControllerCenter currentViewController].navigationController pushViewController:investVC animated:YES];
//    }];
//
//    //活期投资
//    [self registerURI:URI_FREE_INVEST handleBlock:^(NSString *uri, NSString *baseUrl, NSDictionary *parms) {
//        BJHuoQiInvestViewController *investVC = [[BJHuoQiInvestViewController alloc] initWithProductId:[parms[@"product_id"] integerValue]];
//        [[BJViewControllerCenter currentViewController].navigationController pushViewController:investVC animated:YES];
//    }];
//
//    [self registerURI:URI_LOGIN handleBlock:^(NSString *uri, NSString *baseUrl, NSDictionary *parms) {
//        BJLoginViewController *loginVC = [[BJLoginViewController alloc] init];
//        BJNavigationController *navCon = [[BJNavigationController alloc] initWithRootViewController:loginVC];
//        [[BJViewControllerCenter currentViewController] presentViewController:navCon animated:YES completion:nil];
//    }];
//
//    [self registerURI:URI_LOGIN_LOGIN handleBlock:^(NSString *uri, NSString *baseUrl, NSDictionary *parms) {
//        BJLoginViewController *loginVC = [[BJLoginViewController alloc] initWithType:BJLoginVCTypeLogin];
//        BJNavigationController *navCon = [[BJNavigationController alloc] initWithRootViewController:loginVC];
//        [[BJViewControllerCenter currentViewController] presentViewController:navCon animated:YES completion:nil];
//    }];
//
//    [self registerURI:URI_LOGIN_REGISTER handleBlock:^(NSString *uri, NSString *baseUrl, NSDictionary *parms) {
//        BJLoginViewController *loginVC = [[BJLoginViewController alloc] initWithType:BJLoginVCTypeRegister];
//        BJNavigationController *navCon = [[BJNavigationController alloc] initWithRootViewController:loginVC];
//        [[BJViewControllerCenter currentViewController] presentViewController:navCon animated:YES completion:nil];
//    }];
//
//    [self registerURI:URI_RECHARGE handleBlock:^(NSString *uri, NSString *baseUrl, NSDictionary *parms) {
//        BJRechargeViewController *rechargeVC = [[BJRechargeViewController alloc] init];
//        [[BJViewControllerCenter currentViewController].navigationController pushViewController:rechargeVC animated:YES];
//    }];
//
//    [self registerURI:URI_WITHDRAW handleBlock:^(NSString *uri, NSString *baseUrl, NSDictionary *parms) {
//        BJWithdrawViewController *withdrawVC = [[BJWithdrawViewController alloc] init];
//        [[BJViewControllerCenter currentViewController].navigationController pushViewController:withdrawVC animated:YES];
//    }];
//
//    [self registerURI:URI_ME_COUPON handleBlock:^(NSString *uri, NSString *baseUrl, NSDictionary *parms) {
//        BJLiCaiQuanViewController *licaiquanVC = [[BJLiCaiQuanViewController alloc] init];
//        [[BJViewControllerCenter currentViewController].navigationController pushViewController:licaiquanVC animated:YES];
//    }];
//
//    [self registerURI:URI_BIND_PHONE handleBlock:^(NSString *uri, NSString *baseUrl, NSDictionary *parms) {
//        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"BJPhoneSetting" bundle:[NSBundle mainBundle]];
//        BJBindPhoneStepOneViewController *bindPhoneVC = [storyboard instantiateViewControllerWithIdentifier:@"BJBindPhoneStepOneViewController"];
//        [[BJViewControllerCenter currentViewController].navigationController pushViewController:bindPhoneVC animated:YES];
//    }];
//
//    [self registerURI:URI_BIND_EMAIL handleBlock:^(NSString *uri, NSString *baseUrl, NSDictionary *parms) {
//        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"BJEmailSetting" bundle:[NSBundle mainBundle]];
//        BJBindEmailStepOneViewController *bindEmailVC = [storyboard instantiateViewControllerWithIdentifier:@"BJBindEmailStepOneViewController"];
//        [[BJViewControllerCenter currentViewController].navigationController pushViewController:bindEmailVC animated:YES];
//    }];
//
//    [self registerURI:URI_SETTING handleBlock:^(NSString *uri, NSString *baseUrl, NSDictionary *parms) {
//        BJTestViewController *settingVC = [[BJTestViewController alloc] init];
//        [[BJViewControllerCenter currentViewController].navigationController pushViewController:settingVC animated:YES];
//    }];
//
//    [self registerURI:URI_SETTING_BANKCARD handleBlock:^(NSString *uri, NSString *baseUrl, NSDictionary *parms) {
//        BJBankcardViewController *bankcardVC = [[BJBankcardViewController alloc] init];
//        [[BJViewControllerCenter currentViewController].navigationController pushViewController:bankcardVC animated:YES];
//    }];
//
//    [self registerURI:URI_ME_REGULAR handleBlock:^(NSString *uri, NSString *baseUrl, NSDictionary *parms) {
//        BJDingQiViewController *dingqiVC = [[BJDingQiViewController alloc] init];
//        [[BJViewControllerCenter currentViewController].navigationController pushViewController:dingqiVC animated:YES];
//    }];
//
//    [self registerURI:URI_ME_FEEDBACK handleBlock:^(NSString *uri, NSString *baseUrl, NSDictionary *parms) {
//        BJFeedbackViewController *feedbackVC = [[BJFeedbackViewController alloc] init];
//        [[BJViewControllerCenter currentViewController].navigationController pushViewController:feedbackVC animated:YES];
//    }];
//
//    [self registerURI:URI_MESSAGE handleBlock:^(NSString *uri, NSString *baseUrl, NSDictionary *parms) {
//        NSInteger type = [parms[@"type"] integerValue];
//        BJMessageViewType msgType = type == 1 ? BJMessageViewTypeAccount :
//                                    type == 2 ? BJMessageViewTypeSystem :
//                                    type == 3 ? BJMessageViewTypeActivity : BJMessageViewTypeAccount;
//
//        BJMessageTableViewController *msgTableVC = [[BJMessageTableViewController alloc] initWithType:msgType];
//        [[BJViewControllerCenter currentViewController].navigationController pushViewController:msgTableVC animated:YES];
//    }];
//
//    [self registerURI:URI_ME_WX_NOTICE handleBlock:^(NSString *uri, NSString *baseUrl, NSDictionary *parms) {
//        BJWXNoticeViewController *wxNoticeVC = [[BJWXNoticeViewController alloc] init];
//        [[BJViewControllerCenter currentViewController].navigationController pushViewController:wxNoticeVC animated:YES];
//
//    }];
//
//    [self registerURI:URI_ME_YZB handleBlock:^(NSString *uri, NSString *baseUrl, NSDictionary *parms) {
//
//        BJYuezbViewController *yzbVC = [[BJYuezbViewController alloc] init];
//        [[BJViewControllerCenter currentViewController].navigationController pushViewController:yzbVC animated:YES];
//
//    }];
    
}

@end
