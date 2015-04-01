//
//  WorkoutListDoublesPhase2TVC.m
//  90 DWT 1
//
//  Created by Jared Grant on 7/13/12.
//  Copyright (c) 2012 g-rantsoftware.com. All rights reserved.
//

#import "WorkoutListDoublesPhase2TVC.h"
#import "DWT1IAPHelper.h"

@interface WorkoutListDoublesPhase2TVC ()

@end

@implementation WorkoutListDoublesPhase2TVC

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Show or Hide Ads
    if ([[DWT1IAPHelper sharedInstance] productPurchased:@"com.grantsoftware.90DWT1.removeads1"]) {
        
        // User purchased the Remove Ads in-app purchase so don't show any ads.
        self.canDisplayBannerAds = NO;
        
    } else {
        
        // Show the Banner Ad
        self.canDisplayBannerAds = YES;
    }

    // Configure tableview.
    NSArray *tableCell = @[self.cell1,
                            self.cell2,
                            self.cell3,
                            self.cell4,
                            self.cell5,
                            self.cell6,
                            self.cell7,
                            self.cell8,
                            self.cell9,
                            self.cell10];
    NSArray *accessoryIcon = @[@YES,
                                @YES,
                                @YES,
                                @YES,
                                @YES,
                                @YES,
                                @YES,
                                @YES,
                                @YES,
                                @YES];
    [self configureTableView:tableCell :accessoryIcon];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:YES];
    
    // Show or Hide Ads
    if ([[DWT1IAPHelper sharedInstance] productPurchased:@"com.grantsoftware.90DWT1.removeads1"]) {
        
        // User purchased the Remove Ads in-app purchase so don't show any ads.
        self.canDisplayBannerAds = NO;
        
    } else {
        
        // Show the Banner Ad
        self.canDisplayBannerAds = YES;
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    
    [self.tableView reloadData];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 7;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (section == 0) {
        
        return 2;
    }
    
    else if (section == 1) {
        
        return 1;
    }
    
    else if (section == 2) {
        
        return 2;
    }
    
    else if (section == 3) {
        
        return 1;
    }
    
    else if (section == 4) {
        
        return 2;
    }
    
    else if (section == 5) {
        
        return 1;
    }
    
    else {
        return 1;
    }
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
    
    NSString *week = ((DataNavController *)self.parentViewController).week;
    NSArray *workoutArray;
    
    workoutArray = @[@"Full on Cardio",
                    @"Chest + Shoulders + Tri & Ab Workout",
                    @"Plyometrics",
                    @"Full on Cardio",
                    @"Back + Biceps & Ab Workout",
                    @"Yoga",
                    @"Full on Cardio",
                    @"Legs + Back & Ab Workout",
                    @"Judo Chop",
                    @"Stretch or Rest"];
    
    // Week 5
    if ([week isEqualToString:@"Week 5"]) {
        
        if (indexPath.section == 0) {
            
            if (indexPath.row == 0) {
                
                // Full on Cardio 1
                ((DataNavController *)self.parentViewController).index = @1;
                ((DataNavController *)self.parentViewController).workout = workoutArray[0];
            }
            
            else if (indexPath.row == 1) {
                
                // Chest + Shoulders + Tri 1
                ((DataNavController *)self.parentViewController).index = @1;
                ((DataNavController *)self.parentViewController).workout = workoutArray[1];
            }
        }
        
        else if (indexPath.section == 1) {
            
            if (indexPath.row == 0) {
                
                // Plyometrics 4
                ((DataNavController *)self.parentViewController).index = @4;
                ((DataNavController *)self.parentViewController).workout = workoutArray[2];
            }
        }
        
        else if (indexPath.section == 2) {
            
            if (indexPath.row == 0) {
                
                // Full on Cardio 2
                ((DataNavController *)self.parentViewController).index = @2;
                ((DataNavController *)self.parentViewController).workout = workoutArray[3];
            }
            
            else if (indexPath.row == 1) {
                
                // Back + Biceps 1
                ((DataNavController *)self.parentViewController).index = @1;
                ((DataNavController *)self.parentViewController).workout = workoutArray[4];
            }
        }

        else if (indexPath.section == 3) {
            
            if (indexPath.row == 0) {
                
                // Yoga 6
                ((DataNavController *)self.parentViewController).index = @6;
                ((DataNavController *)self.parentViewController).workout = workoutArray[5];
            }
        }

        else if (indexPath.section == 4) {
            
            if (indexPath.row == 0) {
                
                // Full on Cardio 3
                ((DataNavController *)self.parentViewController).index = @3;
                ((DataNavController *)self.parentViewController).workout = workoutArray[6];
            }
            
            else if (indexPath.row == 1) {
                
                // Legs + Back 4
                ((DataNavController *)self.parentViewController).index = @4;
                ((DataNavController *)self.parentViewController).workout = workoutArray[7];
            }
        }

        else if (indexPath.section == 5) {
            
            if (indexPath.row == 0) {
                
                // Judo Chop 5
                ((DataNavController *)self.parentViewController).index = @5;
                ((DataNavController *)self.parentViewController).workout = workoutArray[8];
            }
        }

        else if (indexPath.section == 6) {
            
            if (indexPath.row == 0) {
                
                // Stretch 6
                ((DataNavController *)self.parentViewController).index = @6;
                ((DataNavController *)self.parentViewController).workout = workoutArray[9];
            }
        }
    }

    // Week 6
    else if ([week isEqualToString:@"Week 6"]) {
        
        if (indexPath.section == 0) {
            
            if (indexPath.row == 0) {
                
                // Full on Cardio 4
                ((DataNavController *)self.parentViewController).index = @4;
                ((DataNavController *)self.parentViewController).workout = workoutArray[0];
            }
            
            else if (indexPath.row == 1) {
                
                // Chest + Shoulders + Tri 2
                ((DataNavController *)self.parentViewController).index = @2;
                ((DataNavController *)self.parentViewController).workout = workoutArray[1];
            }
        }
        
        else if (indexPath.section == 1) {
            
            if (indexPath.row == 0) {
                
                // Plyometrics 5
                ((DataNavController *)self.parentViewController).index = @5;
                ((DataNavController *)self.parentViewController).workout = workoutArray[2];
            }
        }
        
        else if (indexPath.section == 2) {
            
            if (indexPath.row == 0) {
                
                // Full on Cardio 5
                ((DataNavController *)self.parentViewController).index = @5;
                ((DataNavController *)self.parentViewController).workout = workoutArray[3];
            }
            
            else if (indexPath.row == 1) {
                
                // Back + Biceps 2
                ((DataNavController *)self.parentViewController).index = @2;
                ((DataNavController *)self.parentViewController).workout = workoutArray[4];
            }
        }
        
        else if (indexPath.section == 3) {
            
            if (indexPath.row == 0) {
                
                // Yoga 7
                ((DataNavController *)self.parentViewController).index = @7;
                ((DataNavController *)self.parentViewController).workout = workoutArray[5];
            }
        }
        
        else if (indexPath.section == 4) {
            
            if (indexPath.row == 0) {
                
                // Full on Cardio 6
                ((DataNavController *)self.parentViewController).index = @6;
                ((DataNavController *)self.parentViewController).workout = workoutArray[6];
            }
            
            else if (indexPath.row == 1) {
                
                // Legs + Back 5
                ((DataNavController *)self.parentViewController).index = @5;
                ((DataNavController *)self.parentViewController).workout = workoutArray[7];
            }
        }
        
        else if (indexPath.section == 5) {
            
            if (indexPath.row == 0) {
                
                // Judo Chop 6
                ((DataNavController *)self.parentViewController).index = @6;
                ((DataNavController *)self.parentViewController).workout = workoutArray[8];
            }
        }
        
        else if (indexPath.section == 6) {
            
            if (indexPath.row == 0) {
                
                // Stretch 7
                ((DataNavController *)self.parentViewController).index = @7;
                ((DataNavController *)self.parentViewController).workout = workoutArray[9];
            }
        }
    }
    
    // Week 7
    else if ([week isEqualToString:@"Week 7"]) {
        
        if (indexPath.section == 0) {
            
            if (indexPath.row == 0) {
                
                // Full on Cardio 7
                ((DataNavController *)self.parentViewController).index = @7;
                ((DataNavController *)self.parentViewController).workout = workoutArray[0];
            }
            
            else if (indexPath.row == 1) {
                
                // Chest + Shoulders + Tri 3
                ((DataNavController *)self.parentViewController).index = @3;
                ((DataNavController *)self.parentViewController).workout = workoutArray[1];
            }
        }
        
        else if (indexPath.section == 1) {
            
            if (indexPath.row == 0) {
                
                // Plyometrics 6
                ((DataNavController *)self.parentViewController).index = @6;
                ((DataNavController *)self.parentViewController).workout = workoutArray[2];
            }
        }
        
        else if (indexPath.section == 2) {
            
            if (indexPath.row == 0) {
                
                // Full on Cardio 8
                ((DataNavController *)self.parentViewController).index = @8;
                ((DataNavController *)self.parentViewController).workout = workoutArray[3];
            }
            
            else if (indexPath.row == 1) {
                
                // Back + Biceps 3
                ((DataNavController *)self.parentViewController).index = @3;
                ((DataNavController *)self.parentViewController).workout = workoutArray[4];
            }
        }
        
        else if (indexPath.section == 3) {
            
            if (indexPath.row == 0) {
                
                // Yoga 8
                ((DataNavController *)self.parentViewController).index = @8;
                ((DataNavController *)self.parentViewController).workout = workoutArray[5];
            }
        }
        
        else if (indexPath.section == 4) {
            
            if (indexPath.row == 0) {
                
                // Full on Cardio 9
                ((DataNavController *)self.parentViewController).index = @9;
                ((DataNavController *)self.parentViewController).workout = workoutArray[6];
            }
            
            else if (indexPath.row == 1) {
                
                // Legs + Back 6
                ((DataNavController *)self.parentViewController).index = @6;
                ((DataNavController *)self.parentViewController).workout = workoutArray[7];
            }
        }
        
        else if (indexPath.section == 5) {
            
            if (indexPath.row == 0) {
                
                // Judo Chop 7
                ((DataNavController *)self.parentViewController).index = @7;
                ((DataNavController *)self.parentViewController).workout = workoutArray[8];
            }
        }
        
        else if (indexPath.section == 6) {
            
            if (indexPath.row == 0) {
                
                // Stretch 8
                ((DataNavController *)self.parentViewController).index = @8;
                ((DataNavController *)self.parentViewController).workout = workoutArray[9];
            }
        }
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *routineWeek;
    
    if (section == 0) {
        
        NSInteger tempsection = section + 1;
        routineWeek = [((DataNavController *)self.parentViewController).routine stringByAppendingFormat:@" - %@ - Day %ld", ((DataNavController *)self.parentViewController).week, (long)tempsection];
    }
    
    else if (section == 1) {
        
        NSInteger tempsection = section + 1;
        routineWeek = [((DataNavController *)self.parentViewController).routine stringByAppendingFormat:@" - %@ - Day %ld", ((DataNavController *)self.parentViewController).week, (long)tempsection];
    }
    
    else if (section == 2) {
        
        NSInteger tempsection = section + 1;
        routineWeek = [((DataNavController *)self.parentViewController).routine stringByAppendingFormat:@" - %@ - Day %ld", ((DataNavController *)self.parentViewController).week, (long)tempsection];
    }
    
    else if (section == 3) {
        
        NSInteger tempsection = section + 1;
        routineWeek = [((DataNavController *)self.parentViewController).routine stringByAppendingFormat:@" - %@ - Day %ld", ((DataNavController *)self.parentViewController).week, (long)tempsection];
    }
    
    else if (section == 4) {
        
        NSInteger tempsection = section + 1;
        routineWeek = [((DataNavController *)self.parentViewController).routine stringByAppendingFormat:@" - %@ - Day %ld", ((DataNavController *)self.parentViewController).week, (long)tempsection];
    }
    
    else if (section == 5) {
        
        NSInteger tempsection = section + 1;
        routineWeek = [((DataNavController *)self.parentViewController).routine stringByAppendingFormat:@" - %@ - Day %ld", ((DataNavController *)self.parentViewController).week, (long)tempsection];
    }
    
    else {
        
        NSInteger tempsection = section + 1;
        routineWeek = [((DataNavController *)self.parentViewController).routine stringByAppendingFormat:@" - %@ - Day %ld", ((DataNavController *)self.parentViewController).week, (long)tempsection];
    }
    
    return routineWeek;
}
@end
