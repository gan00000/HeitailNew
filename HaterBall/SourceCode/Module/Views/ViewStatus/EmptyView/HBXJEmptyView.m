#import "HBXJEmptyView.h"
@implementation HBXJEmptyView
- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = RGBA_COLOR_HEX(0xf4f4f4);
    self.contentLabel.textColor = RGBA_COLOR_HEX(0x666666);
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(contentTapAction)];
    [self.contentLabel addGestureRecognizer:tap];
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(contentTapAction)];
    [self.imageView addGestureRecognizer:tap1];
}
- (void)contentTapAction {
    if (self.contentTapBlock) {
        self.contentTapBlock();
    }
}
@end
