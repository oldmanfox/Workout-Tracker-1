//
//  SettingsTVC.h
//  i90X
//
//  Created by Jared Grant on 7/11/12.
//  Copyright (c) 2012 g-rantsoftware.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingsNavController.h"
#import "DataNavController.h"
#import "MainTBC.h"
#import "EmailViewController.h"

@interface SettingsTVC : UITableViewController
@property (strong, nonatomic) IBOutlet UITableViewCell *cell1; // Email.  Default is youremail@abc.com.
@property (strong, nonatomic) IBOutlet UITableViewCell *cell2; // Version
@property (strong, nonatomic) IBOutlet UITableViewCell *cell3; // Author
@property (strong, nonatomic) IBOutlet UITableViewCell *cell4; // Website
@property (strong, nonatomic) IBOutlet UILabel *emailDetail;
@property (strong, nonatomic) IBOutlet UISegmentedControl *defaultWorkout; // Classic, Lean, or Doubles.  Default is Classic.
- (IBAction)selectDefaultWorkout:(id)sender;

@end
