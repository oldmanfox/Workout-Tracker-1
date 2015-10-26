//
//  WorkoutListDoublesPhase3-2TVC.h
//  90 DWT 1
//
//  Created by Jared Grant on 7/14/12.
//  Copyright (c) 2012 g-rantsoftware.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataNavController.h"
#import "UITableViewController+Design.h"
//#import <iAd/iAd.h>
#import "MPAdView.h"

@interface WorkoutListDoublesPhase3_2TVC : UITableViewController <MPAdViewDelegate>

@property (nonatomic) MPAdView *adView;

@property (nonatomic, strong) UIView *headerView;

@property (weak, nonatomic) IBOutlet UITableViewCell *cell1;
@property (weak, nonatomic) IBOutlet UITableViewCell *cell2;
@property (weak, nonatomic) IBOutlet UITableViewCell *cell3;
@property (weak, nonatomic) IBOutlet UITableViewCell *cell4;
@property (weak, nonatomic) IBOutlet UITableViewCell *cell5;
@property (weak, nonatomic) IBOutlet UITableViewCell *cell6;
@property (weak, nonatomic) IBOutlet UITableViewCell *cell7;
@property (weak, nonatomic) IBOutlet UITableViewCell *cell8;
@property (weak, nonatomic) IBOutlet UITableViewCell *cell9;
@property (weak, nonatomic) IBOutlet UITableViewCell *cell10;
@property (weak, nonatomic) IBOutlet UITableViewCell *cell11;

@end
