//
//  EmailViewController.h
//  i90X
//
//  Created by Jared Grant on 7/12/12.
//  Copyright (c) 2012 g-rantsoftware.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingsNavController.h"

@interface EmailViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *defaultEmail;

- (IBAction)hideKeyboard:(id)sender;
- (IBAction)saveEmail:(id)sender;
@end
