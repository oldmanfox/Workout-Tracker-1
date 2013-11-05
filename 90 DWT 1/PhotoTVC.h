//
//  PhotoTVC.h
//  i90X
//
//  Created by Jared Grant on 7/14/12.
//  Copyright (c) 2012 g-rantsoftware.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoScrollerViewController.h"
#import "PresentPhotosViewController.h"

@interface PhotoTVC : UITableViewController
@property (strong, nonatomic) IBOutlet UITableViewCell *cell1;
@property (strong, nonatomic) IBOutlet UITableViewCell *cell2;
@property (strong, nonatomic) IBOutlet UITableViewCell *cell3;
@property (strong, nonatomic) IBOutlet UITableViewCell *cellFinal;
@property (strong, nonatomic) IBOutlet UITableViewCell *cellAll;
@property (strong, nonatomic) IBOutlet UITableViewCell *cellFront;
@property (strong, nonatomic) IBOutlet UITableViewCell *cellSide;
@property (strong, nonatomic) IBOutlet UITableViewCell *cellBack;

@end
