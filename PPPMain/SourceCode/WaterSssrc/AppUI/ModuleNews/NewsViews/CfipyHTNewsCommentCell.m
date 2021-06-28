#import "CfipyHTNewsCommentCell.h"
#import "BlysaBJDateFormatUtility.h"
#import "NSNiceHTUserRequest.h"
#import "UUaksHTCommentExpendCell.h"
#import <YYText/YYText.h>
#import "UIImageView+FFlaliHT.h"

@interface CfipyHTNewsCommentCell () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet JXImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@property (weak, nonatomic) IBOutlet UILabel *timelabel;
@property (weak, nonatomic) IBOutlet UILabel *replyCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UITableView *replyTableView;
@property (weak, nonatomic) IBOutlet UIButton *replyButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *replyTableViewHeitht;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *replyTableViewTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *avatarWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *avatarTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *avatarLeft;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *avatarRight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *timeLabelTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *commentLabelRight;
@property (nonatomic, weak) WSKggHTCommentModel *commentModel;
@end
@implementation CfipyHTNewsCommentCell
- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.replyTableView.layer.cornerRadius = 4;
    self.replyTableView.layer.borderWidth = 0.5;
    self.replyTableView.layer.borderColor = [UIColor hx_colorWithHexRGBAString:@"dddddd"].CGColor;
    self.replyTableView.scrollEnabled = NO;
    self.replyTableView.delegate = self;
    self.replyTableView.dataSource = self;
    self.replyTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.replyTableView registerNib:[UINib nibWithNibName:NSStringFromClass([self class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([self class])];
    [self.replyTableView registerNib:[UINib nibWithNibName:NSStringFromClass([UUaksHTCommentExpendCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([UUaksHTCommentExpendCell class])];
    UIImage *image = [[UIImage imageNamed:@"gurk_icon_add_like"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [self.likeButton setImage:image forState:UIControlStateNormal];
    [self.likeButton setTitleColor:appBaseColor forState:UIControlStateSelected];
    [self.likeButton setTitleColor:[UIColor hx_colorWithHexRGBAString:@"999999"] forState:UIControlStateNormal];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (void)taorefreshWithCommentModel:(WSKggHTCommentModel *)commentModel {
    self.commentModel = commentModel;
//    self.avatarImageView.image = commentModel.userModel.avatar;
     [self.avatarImageView th_setImageWithURL:commentModel.userModel.user_img placeholderImage:HT_DEFAULT_AVATAR_LOGO];
    
    self.authorLabel.text = commentModel.comment_author;
    self.commentLabel.text = commentModel.comment_content;
    self.timelabel.text = [BlysaBJDateFormatUtility dateToShowFromDate:commentModel.date];
    self.replyCountLabel.text = [NSString stringWithFormat:@"%ld回覆", commentModel.total_reply];
    if (commentModel.my_like) {
        self.likeButton.selected = YES;
        [self.likeButton setTintColor:appBaseColor];
    } else {
        self.likeButton.selected = NO;
        [self.likeButton setTintColor:[UIColor hx_colorWithHexRGBAString:@"999999"]];
    }
    if (commentModel.total_like > 0) {
        [self.likeButton setTitle:[NSString stringWithFormat:@"%ld", commentModel.total_like]
                         forState:UIControlStateNormal];
    } else {
        [self.likeButton setTitle:@"讃" forState:UIControlStateNormal];
    }
    if (commentModel.isReply) {
        self.replyTableViewHeitht.constant = 0;
        self.replyTableViewTop.constant = 8;
        self.replyTableView.hidden = YES;
        self.avatarWidth.constant = 16;
        self.avatarLeft.constant = 6;
        self.avatarRight.constant = 6;
        self.avatarTop.constant = 6;
        self.timeLabelTop.constant = 6;
        self.avatarImageView.cornerRadius = 8;
        self.commentLabelRight.constant = 10;
        self.authorLabel.font = [UIFont systemFontOfSize:14];
        self.timelabel.font = [UIFont systemFontOfSize:11];
        self.replyButton.titleLabel.font = [UIFont systemFontOfSize:11];
        self.replyCountLabel.font = [UIFont systemFontOfSize:11];
        NSString *at = [NSString stringWithFormat:@"@%@", commentModel.reply_to_display_name];
        NSRange range = [commentModel.comment_content rangeOfString:at];
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:commentModel.comment_content];
        attr.yy_font = [UIFont systemFontOfSize:12];
        attr.yy_color = [UIColor hx_colorWithHexRGBAString:@"222222"];
        [attr yy_setColor:[UIColor hx_colorWithHexRGBAString:@"4E8BFF"] range:range];
        self.commentLabel.attributedText = attr;
        self.replyCountLabel.hidden = YES;
    } else {
        if (commentModel.replyHeight == 0) {
            self.replyTableViewTop.constant = 10;
        } else {
            self.replyTableViewTop.constant = 5;
        }
        [UIView animateWithDuration:0.25 animations:^{
            self.replyTableViewHeitht.constant = commentModel.replyHeight;
            [self layoutIfNeeded];
        }];
        [self.replyTableView reloadData];
    }
}
- (IBAction)onReplyAction:(id)sender {
    if (![TuTuosHTUserManager tao_isUserLogin]) {
        [TuTuosHTUserManager tao_doUserLogin];
        return;
    }
    if (self.onReplyBlock) {
        self.onReplyBlock(self.commentModel);
    }
}
- (IBAction)onLikeAction:(UIButton *)sender {
    if (![TuTuosHTUserManager tao_isUserLogin]) {
        [TuTuosHTUserManager tao_doUserLogin];
        return;
    }
    UIView *view = [CfipyPPXXBJViewControllerCenter currentViewController].view;
    [NSNiceHTUserRequest taolikePostWithPostId:self.commentModel.post_id comment_id:self.commentModel.comment_id like:!sender.selected successBlock:^{
        if (self.commentModel.my_like) {
            self.commentModel.total_like --;
            [view showToast:@"已取消點讚"];
        } else {
            self.commentModel.total_like ++;
            [view showToast:@"已點讚"];
        }
        self.commentModel.my_like = !self.commentModel.my_like;
        [self taorefreshWithCommentModel:self.commentModel];
    } failBlock:^(WSKggBJError *error) {
        if (sender.selected) {
            [view showToast:@"取消點讚失敗"];
        } else {
            [view showToast:@"點讚失敗"];
        }
    }];
}
#pragma mark - UITaleVeiwDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.commentModel.reply.count <= 3) {
        return self.commentModel.reply.count;
    }
    return self.commentModel.reply.count + 1;;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.commentModel.reply.count <= 3 ||
        (self.commentModel.expend && indexPath.row < self.commentModel.reply.count) ||
        indexPath.row < 3) {
        CfipyHTNewsCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
        cell.onReplyBlock = ^(WSKggHTCommentModel * _Nonnull commentModel) {
            if (self.onReplyBlock) {
                self.onReplyBlock(commentModel);
            }
        };
        [cell taorefreshWithCommentModel:self.commentModel.reply[indexPath.row]];
        return cell;
    }
    kWeakSelf
    UUaksHTCommentExpendCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UUaksHTCommentExpendCell class])];
    cell.onExpendChangeBlock = ^(BOOL expend) {
        weakSelf.commentModel.expend = expend;
        [weakSelf taorefreshWithCommentModel:weakSelf.commentModel];
        if (weakSelf.onExpendBlock) {
            weakSelf.onExpendBlock();
            [weakSelf.replyTableView reloadData];
        }
    };
    return cell;
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.commentModel.reply.count <= 3 ||
        (self.commentModel.expend && indexPath.row < self.commentModel.reply.count) ||
        indexPath.row < 3) {
        WSKggHTCommentModel *model = self.commentModel.reply[indexPath.row];
        return model.cellHeight;
    }
    return 40;
}
@end
