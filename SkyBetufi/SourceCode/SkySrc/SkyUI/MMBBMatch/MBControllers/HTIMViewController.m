//
//  HTIMViewController.m
//  SkyBallPlay
//
//  Created by ganyuanrong on 2020/9/12.
//  Copyright © 2020 Dean_F. All rights reserved.
//

#import "HTIMViewController.h"
#import <SocketRocket.h>
#import "UserMessage.pbobjc.h"
#import "InfoMessage.pbobjc.h"
#import "HTChatContentCell.h"
#import "ConfigCoreUtil.h"
#import "UIColor+Hex.h"

@interface HTIMViewController () <UITableViewDelegate, UITableViewDataSource, SRWebSocketDelegate>
@property (weak, nonatomic) IBOutlet UIView *notShowImView;
@property (weak, nonatomic) IBOutlet UIView *showImView;
@property (weak, nonatomic) IBOutlet UITableView *imContentTableView;
//@property (weak, nonatomic) IBOutlet UITextField *imTalkTextField;
@property (weak, nonatomic) IBOutlet UILabel *gameStatueLabel;
@property (weak, nonatomic) IBOutlet JXTextView *imTalkTextView;

@property (strong, nonatomic) SRWebSocket *socket;
@property (strong,nonatomic) NSTimer *heatBeatTimer;
@property (nonatomic) BOOL loginSuccess;
@property (nonatomic, strong) NSMutableArray<MsgChatContent*> *chatContentList;
@property (nonatomic) BOOL dataIsSet;

@property (nonatomic) SkyBallHetiRedHTMatchHomeModel *matchModel;
@end

@implementation HTIMViewController


+ (instancetype)waterSkyviewController {
    return kLoadStoryboardWithName(@"THIMController");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.loginSuccess = NO;
    self.dataIsSet = NO;
    self.chatContentList = [[NSMutableArray alloc] init];
    
    [self setupViews];
    
    self.showImView.hidden = YES;
    self.notShowImView.hidden = NO;
}
- (void)dealloc {
    NSLog(@"%@ dealloc", NSStringFromClass(self.class));
}

- (void)viewWillAppear:(BOOL)animated{
    
}
- (void)viewWillDisappear:(BOOL)animated{
    
}

- (void)viewDidAppear:(BOOL)animated{
    
}

- (void)viewDidDisappear:(BOOL)animated{
    [self destory];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)setData:(SkyBallHetiRedHTMatchHomeModel *)model summary:(SkyBallHetiRedHTMatchSummaryModel *)summaryModel
{
    
    //    if ([summaryModel.scheduleStatus isEqualToString:@"Final"]) {
    //
    //    } else if ([summaryModel.scheduleStatus isEqualToString:@"InProgress"]) {
    //
    //    } else if ([summaryModel.scheduleStatus isEqualToString:@"Canceled"]) {
    //        //self.statusLabel.text = @"已取消";
    //    } else  {
    //        //self.statusLabel.text = @"未開始";
    //
    //    }
    if (self.dataIsSet) {
        return;
    }
    self.matchModel = model;
    NSString *timeStr = [NSString stringWithFormat:@"%@ %@",model.gamedate, [model.time uppercaseString]];
    NSString *timeStamp = [ConfigCoreUtil getTimeStrWithString: timeStr];
    
    double now_timestamp = [[ConfigCoreUtil getTimeStamp] doubleValue];
    double game_timestamp = [timeStamp doubleValue];
    if (now_timestamp < (game_timestamp - 1 * 60 * 60 * 1000)) { //游戏未开始
        self.showImView.hidden = YES;
        self.notShowImView.hidden = NO;
        self.gameStatueLabel.text = @"比賽未開始";
    }else if(now_timestamp > (game_timestamp + 5 * 60 * 60 * 1000)){ //游戏结束
        self.showImView.hidden = YES;
        self.notShowImView.hidden = NO;
        self.gameStatueLabel.text = @"比賽已結束";
    }else{
        
        self.showImView.hidden = NO;
        self.notShowImView.hidden = YES;
        [self initWebSocket];
    }
    self.dataIsSet = YES;
    
    
    //調試代碼start
//    self.showImView.hidden = NO;
//    self.notShowImView.hidden = YES;
//    [self initWebSocket];
    //調試代碼end
    
    
}

- (IBAction)sendBtnAction:(id)sender {
    
    NSString *content = self.imTalkTextView.text;
    if (!content) {
        [kWindow showToast:@"請輸入內容"];
        return;
    }
    
    if (!self.loginSuccess) {
        [kWindow showToast:@"請先登入帳號"];
        return;
    }
    
    SendChatReq_1002 *chatReq = [[SendChatReq_1002 alloc] init];
    chatReq.content = content;
    chatReq.gameId = [self.matchModel.game_id integerValue];
    if ([self sendData:1002 data:[chatReq data]]) {
        self.imTalkTextView.text = nil;
        [self.view endEditing:YES];
    }
}

- (void)setupViews {
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"f3f3f4"];
    self.imContentTableView.backgroundColor = [UIColor colorWithHexString:@"f3f3f4"];
    self.imTalkTextView.backgroundColor = [UIColor colorWithHexString:@"f3f3f4"];
    self.imTalkTextView.layer.cornerRadius = 10;
    
    self.imContentTableView.delegate = self;
    self.imContentTableView.dataSource = self;
    self.imContentTableView.estimatedRowHeight = 40;
    [self.imContentTableView setAllowsSelection:NO];
    self.imContentTableView.rowHeight = UITableViewAutomaticDimension;
    self.imContentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    if (@available(iOS 11.0, *)) {
        self.imContentTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self.imContentTableView registerNib:[UINib nibWithNibName:NSStringFromClass([HTChatContentCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([HTChatContentCell class])];
    //    kWeakSelf
    //    self.imContentTableView.mj_header = [SkyBallHetiRedMJRefreshGenerator bj_headerWithRefreshingBlock:^{
    //        if (weakSelf.onTableHeaderRefreshBlock) {
    //            weakSelf.onTableHeaderRefreshBlock();
    //        }
    //    }];
    
    //    [self.imTalkTextView  becomeFirstResponder];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onInputBegin) name:UITextViewTextDidBeginEditingNotification object:self.imTalkTextView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onInputEnd) name:UITextViewTextDidEndEditingNotification object:self.imTalkTextView];
    
}

- (void)onInputBegin {
    //    if (![SkyBallHetiRedHTUserManager waterSky_isUserLogin]) {
    //        [self.view endEditing:YES];
    //        [SkyBallHetiRedHTUserManager waterSky_doUserLogin];
    //        [self.view showToast:@"請登錄"];
    //        return;
    //    }
    
    [UIView animateWithDuration:0.25 animations:^{
        
        [self.imTalkTextView.superview layoutIfNeeded];
    }];
}
- (void)onInputEnd {
    if (self.imTalkTextView.text.length == 0) {
        
        [UIView animateWithDuration:0.25 animations:^{
            
            [self.imTalkTextView.superview layoutIfNeeded];
        }];
    }
}

//初始化 WebSocket
- (void)initWebSocket{
    if (_socket) {
        [_socket close];
        _socket = nil;
        // return;
    }
    //Url
    NSURL *url = [NSURL URLWithString:@"ws://app.ballgametime.com/chat"];
    //请求
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30];
    //初始化请求`
    _socket = [[SRWebSocket alloc] initWithURLRequest:request];
    //代理协议`
    _socket.delegate = self;
    // 实现这个 SRWebSocketDelegate 协议啊`
    //直接连接`
    [_socket open];    // open 就是直接连接了
}

#pragma mark -- SRWebSocketDelegate
//收到服务器消息是回调
- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message{
    //NSLog(@"收到服务器返回消息：%@",message);
    NSLog(@"收到服务器返回消息");
    NSData *msgData = (NSData *)message;
    [self parseMsgData:msgData];
}

//连接成功
- (void)webSocketDidOpen:(SRWebSocket *)webSocket{
    NSLog(@"连接成功");
    [self initHeart];   //开启心跳
    
    if (self.socket != nil) {
        // 只有 SR_OPEN 开启状态才能调 send 方法啊，不然要崩
        if (_socket.readyState == SR_OPEN) {
            
            //用户登录
            if (SkyBallHetiRedHTUserManager.waterSky_userToken && ![@"" isEqualToString:SkyBallHetiRedHTUserManager.waterSky_userToken]) {
                [self sendLoginData];
            }
            
            
        } else if (_socket.readyState == SR_CONNECTING) {
            NSLog(@"正在连接中，重连后其他方法会去自动同步数据");
            // 每隔2秒检测一次 socket.readyState 状态，检测 10 次左右
            // 只要有一次状态是 SR_OPEN 的就调用 [ws.socket send:data] 发送数据
            // 如果 10 次都还是没连上的，那这个发送请求就丢失了，这种情况是服务器的问题了，小概率的
            // 代码有点长，我就写个逻辑在这里好了
            
        } else if (_socket.readyState == SR_CLOSING || _socket.readyState == SR_CLOSED) {
            // websocket 断开了，调用 reConnect 方法重连
            [self reConnect];
        }
    } else {
        NSLog(@"没网络，发送失败，一旦断网 socket 会被我设置 nil 的");
        NSLog(@"其实最好是发送前判断一下网络状态比较好，我写的有点晦涩，socket==nil来表示断网");
        [kWindow showToast:@"網絡連接失敗，請重新打開頁面"];
    }
}

//连接失败的回调
- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error{
    NSLog(@"连接失败，这里可以实现掉线自动重连，要注意以下几点");
    NSLog(@"1.判断当前网络环境，如果断网了就不要连了，等待网络到来，在发起重连");
    NSLog(@"2.判断调用层是否需要连接，例如用户都没在聊天界面，连接上去浪费流量");
    //关闭心跳包
    [webSocket close];
    
    [self reConnect];
}

//连接断开的回调
- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean;
{
    NSLog(@"webSocket didCloseWithCode:%d, reason:%@",code,reason);
}

- (void)webSocket:(SRWebSocket *)webSocket didReceivePong:(NSData *)pongPayload;
{
    NSLog(@"webSocket didReceivePong");
    //[self parseMsgData:pongPayload];
}



#pragma mark -- SRWebSocket链接，发消息相关
//保活机制  探测包
- (void)initHeart{
    __weak typeof(self) weakSelf = self;
    
    if (@available(iOS 10.0, *)) {
        
        if (_heatBeatTimer) {
            [_heatBeatTimer invalidate];
            _heatBeatTimer = nil;
        }
        NSLog(@"开启15秒心跳");
        _heatBeatTimer = [NSTimer scheduledTimerWithTimeInterval:15 repeats:YES block:^(NSTimer * _Nonnull timer) {
            [weakSelf sendHeartbeatMessage];
            
        }];
        [[NSRunLoop currentRunLoop] addTimer:_heatBeatTimer forMode:NSRunLoopCommonModes];
    } else {
        // Fallback on earlier versions
    }
    
}

-(void)sendHeartbeatMessage
{
    NSLog(@"發送心跳...");
    HeartbeatConnectReq_0 *req = [[HeartbeatConnectReq_0 alloc] init];
    NSData *heartBeatData = [req data];
    [self sendData:0 data:heartBeatData];
}

-(void)sendLoginData
{
    LoginReq_1001 *req = [[LoginReq_1001 alloc] init];
    req.token = SkyBallHetiRedHTUserManager.waterSky_userToken;
    [self sendData:1001 data:[req data]];
}

-(BOOL)sendData:(int)type data:(NSData *)data
{
    if (_socket.readyState == SR_OPEN) {
        //         HeartbeatConnectReq_0 *req = [[HeartbeatConnectReq_0 alloc] init];
        //         NSData *heartBeatData = [req data];
        NSMutableData *xxData = [[NSMutableData alloc] initWithCapacity:14 + data.length];
        
        int msgType = type;
        //         NSData *msgTypeData = [NSData dataWithBytes:&msgType length:4];
        [xxData appendData:[self int2Data:msgType]];
        
        int msgLength = data.length + 2;
        //         NSData *msgLengthData = [NSData dataWithBytes:&msgLength length:4];
        [xxData appendData:[self int2Data:msgLength]];
        
        Byte byte101 = 101;
        NSData *data101 = [[NSData alloc] initWithBytes:&byte101 length:1];
        [xxData appendData:data101];
        
        Byte byte1 = 1;
        NSData *data1 = [[NSData alloc] initWithBytes:&byte1 length:1];
        [xxData appendData:data1];
        
        int aa = 1;
        //         NSData *aaData = [NSData dataWithBytes:&aa length:sizeof(aa)];
        [xxData appendData:[self int2Data:aa]];
        
        [xxData appendData:data];
        
        if (_socket) {
            BJLog(@"sendHeartbeatMessage");
            [_socket send:xxData];
            return YES;
        }
        
    }else{
         [kWindow showToast:@"斷線重連中..."];
        [self reConnect];
    }
    
    return NO;
}


- (void)parseMsgData:(NSData *)msgData {
    
    if (msgData) {
        //        Byte msgIdByte[4] = {0};
        //int msgId;
        //        [msgData getBytes:msgIdByte range:NSMakeRange(0, 4)];
        int msgId = [self data2Int:[msgData subdataWithRange:NSMakeRange(0, 4)]];
        
        int msgSize = [self data2Int:[msgData subdataWithRange:NSMakeRange(4, 4)]];
        //        [msgData getBytes:&msgSize range:NSMakeRange(4, 4)];
        Byte key;
        [msgData getBytes:&key range:NSMakeRange(8, 1)];
        Byte type;
        [msgData getBytes:&type range:NSMakeRange(9, 1)];
        
        int serverId = [self data2Int:[msgData subdataWithRange:NSMakeRange(10, 4)]];
        //        [msgData getBytes:&serverId range:NSMakeRange(10, 4)];
        
        NSData *contentData = [msgData subdataWithRange:NSMakeRange(14, msgSize-2)];
        
        //        NSData *data4 = [pongPayload subdataithRange:NSMakeRange(0, 4)];
        //        int value = CFSwapInt32BigToHost(*(int*)([data4 bytes]));
        NSLog(@"msgId: %d",msgId);
        NSError *err = nil;
        if (msgId == 0) {
            
            HeartbeatConnectResp_0 *beatResp = [HeartbeatConnectResp_0 parseFromData:contentData error:&err];
            NSLog(@"心跳完成 serverTime:%ld", beatResp.serverTime);
        }else if(msgId == 1001){
            
            LoginResp_1001 *loginResp = [LoginResp_1001 parseFromData:contentData error:&err];
            if (!err) {
                NSLog(@"登录完成 name:%@,token:%@",loginResp.msgUser.name,loginResp.msgUser.token);
                self.loginSuccess = YES;
            }
        }else if(msgId == 1002){
            
            SendChatResp_1002 *chatResp = [SendChatResp_1002 parseFromData:contentData error:&err];
            if (!err && chatResp) {
                NSMutableArray<MsgChatContent*> *chatContentArray = chatResp.msgChatContentArray;
                
                for (MsgChatContent *msgContent in chatContentArray) {
                    NSString *msg = msgContent.content;
                    int64_t gameId = msgContent.gameId;
                    // NSString *fromUserName = msgContent.fromUserName;
                    NSLog(@"消息: msg:%@, gameId: %ld", msg, gameId);
                    if ([self.matchModel.game_id intValue] == gameId) {
                        if (self.chatContentList.count > 1000) {//防止数据太多内存泄露，最多1000条
                            [self.chatContentList removeObjectAtIndex:0];
                        }
                        [self.chatContentList addObject: msgContent];
                    }
                }
                
                 [self.imContentTableView reloadData];
                [self scrollToBottom];
            }
            
        }
    }
}

-(void) scrollToBottom
{
    if(self.chatContentList.count > 0){

    NSIndexPath *indexpath = [NSIndexPath indexPathForRow:self.chatContentList.count-1 inSection:0];

        [self.imContentTableView scrollToRowAtIndexPath:indexpath atScrollPosition:UITableViewScrollPositionBottom animated:NO];

    }
    
}

//断开连接时销毁心跳
- (void)destory{
    NSLog(@"销毁心跳和连接");
    [_heatBeatTimer invalidate];
    _heatBeatTimer = nil;
    [_socket close];
    _socket = nil;
}

- (void)reConnect{
    //每隔一段时间重连一次
    //规定64不在重连,2的指数级
    //    if (_reConnectTime > 60) {
    //        return;
    //    }
    //
    NSLog(@"设置重连...");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.socket = nil;
        NSLog(@"开始重连...");
        [self initWebSocket];
    });
    //
    //    if (_reConnectTime == 0) {
    //        _reConnectTime = 2;
    //    }else{
    //        _reConnectTime *= 2;
    //    }
}

// NSData转int
- (int)data2Int:(NSData *)data{
    Byte *byte = (Byte *)[data bytes];
    // 有大小端模式问题？
    return (byte[0] << 24) + (byte[1] << 16) + (byte[2] << 8) + (byte[3]);
}

// int转NSData
- (NSData *)int2Data:(int)i{
    Byte b0 = i & 0xff;
    Byte b1 = i >> 8 & 0xff;
    Byte b2 = i >> 16 & 0xff;
    Byte b3 = i >> 24 & 0xff;
    // 有大小端模式问题？
    //Byte result[] = {b0, b1, b2, b3};
    Byte result[] = {b3, b2, b1, b0};
    return [NSData dataWithBytes:result length:sizeof(result)];
    
    //    Byte byte[4] = {};
    //    byte[0] =  (Byte) ((value>>24) & 0xFF);
    //    byte[1] =  (Byte) ((value>>16) & 0xFF);
    //    byte[2] =  (Byte) ((value>>8) & 0xFF);
    //    byte[3] =  (Byte) (value & 0xFF);
    
}

#pragma mark - UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.chatContentList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MsgChatContent *chatContent = self.chatContentList[indexPath.row];
    HTChatContentCell *cell = (HTChatContentCell *)[tableView dequeueReusableCellWithIdentifier:@"HTChatContentCell"];
    [cell setChaMsg:[NSString stringWithFormat:@"%@ - %@", chatContent.content, chatContent.fromUserName]];
    return cell;
}
@end
