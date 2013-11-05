//
//  ExerciseViewController.h
//  i90X
//
//  Created by Jared Grant on 7/15/12.
//  Copyright (c) 2012 g-rantsoftware.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>
#import "DataNavController.h"
#import "AppDelegate.h"
#import "ResultsViewController.h"
#import "AppDelegate.h"

@interface ExerciseViewController : UIViewController <ADBannerViewDelegate>
@property (strong, nonatomic) IBOutlet UITextField *currentReps;
@property (strong, nonatomic) IBOutlet UITextField *currentWeight;
@property (strong, nonatomic) IBOutlet UITextField *currentNotes;
@property (strong, nonatomic) IBOutlet UILabel *exerciseName;
@property (strong, nonatomic) IBOutlet UILabel *round;
@property (strong, nonatomic) IBOutlet UITextField *previousReps;
@property (strong, nonatomic) IBOutlet UITextField *previousWeight;
@property (strong, nonatomic) IBOutlet UITextField *previousNotes;

- (IBAction)submitEntry:(id)sender;
- (IBAction)hideKeyboard:(id)sender;

@end
