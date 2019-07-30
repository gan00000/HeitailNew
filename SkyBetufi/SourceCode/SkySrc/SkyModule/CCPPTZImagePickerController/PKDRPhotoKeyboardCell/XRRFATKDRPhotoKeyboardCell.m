#import "XRRFATKDRPhotoKeyboardCell.h"
@interface XRRFATKDRPhotoKeyboardCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UIButton *delectButton;
@end
@implementation XRRFATKDRPhotoKeyboardCell
- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor whiteColor];
}
+ (CGSize)cellSize {
    return CGSizeMake(95.0, 95.0);
}
- (void)setImage:(UIImage *)image {
    _image = image;
    if (image == nil) {
        self.iconView.image = [UIImage imageNamed:@"notenew_icon_photo"];
        self.delectButton.hidden = YES;
    } else {
        self.iconView.image = self.image;
        self.delectButton.hidden = NO;
    }
}
- (IBAction)deleteAction:(id)sender {
    self.deleteBlock ? self.deleteBlock() : nil;
}
- (UIView *)snapshotView {
    UIView *snapshotView = [[UIView alloc] init];
    UIView *cellSnapshotView = nil;
    if ([self respondsToSelector:@selector(snapshotViewAfterScreenUpdates:)]) {
        cellSnapshotView = [self snapshotViewAfterScreenUpdates:NO];
    } else {
        CGSize size = CGSizeMake(self.bounds.size.width + 20, self.bounds.size.height + 20);
        UIGraphicsBeginImageContextWithOptions(size, self.opaque, 0);
        [self.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage * cellSnapshotImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        cellSnapshotView = [[UIImageView alloc]initWithImage:cellSnapshotImage];
    }
    snapshotView.frame = CGRectMake(0, 0, cellSnapshotView.frame.size.width, cellSnapshotView.frame.size.height);
    cellSnapshotView.frame = CGRectMake(0, 0, cellSnapshotView.frame.size.width, cellSnapshotView.frame.size.height);
    [snapshotView addSubview:cellSnapshotView];
    return snapshotView;
}
@end
