//
//  Copyright (c) 2013-2016 Cédric Luthi. All rights reserved.
//

@import UIKit;

#import "VideoPickerController.h"

@interface SkyFullScreenViewController : UIViewController <UITextFieldDelegate, VideoPickerControllerDelegate>

@property (nonatomic, weak) IBOutlet UITextField *videoIdentifierTextField;
@property (nonatomic, weak) IBOutlet UISwitch *lowQualitySwitch;

- (IBAction) play:(id)sender;

@end
