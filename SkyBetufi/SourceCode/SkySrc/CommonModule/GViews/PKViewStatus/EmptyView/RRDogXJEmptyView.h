#import <UIKit/UIKit.h>
@interface RRDogXJEmptyView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (nonatomic, copy) dispatch_block_t contentTapBlock;
@end