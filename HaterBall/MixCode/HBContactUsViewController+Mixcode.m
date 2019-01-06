#import "HBContactUsViewController+Mixcode.h"
@implementation HBContactUsViewController (Mixcode)
- (void)viewDidLoadMixcode:(NSString *)mixcode {
    NSLog(@"%@", mixcode);
}
- (void)emailTapped:(id)sender mixcode:(NSString *)mixcode {
    NSLog(@"%@", mixcode);
}
- (void)fansTapped:(id)sender mixcode:(NSString *)mixcode {
    NSLog(@"%@", mixcode);
}

@end
