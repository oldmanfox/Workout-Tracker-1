//
//  MeasurementsTVC.h
//  i90X
//
//  Created by Jared Grant on 7/14/12.
//  Copyright (c) 2012 g-rantsoftware.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MeasurementsViewController.h"
#import "MeasurementsReportViewController.h"
#import "MeasurementsNavController.h"

@interface MeasurementsTVC : UITableViewController
@property (strong, nonatomic) IBOutlet UITableViewCell *cell1;
@property (strong, nonatomic) IBOutlet UITableViewCell *cell2;
@property (strong, nonatomic) IBOutlet UITableViewCell *cell3;
@property (strong, nonatomic) IBOutlet UITableViewCell *cellFinal;
@property (strong, nonatomic) IBOutlet UITableViewCell *cellAll;

@end
