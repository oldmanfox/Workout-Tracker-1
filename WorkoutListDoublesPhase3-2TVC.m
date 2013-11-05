//
//  WorkoutListDoublesPhase3-2TVC.m
//  90 DWT 1
//
//  Created by Jared Grant on 7/14/12.
//  Copyright (c) 2012 g-rantsoftware.com. All rights reserved.
//

#import "WorkoutListDoublesPhase3-2TVC.h"

@interface WorkoutListDoublesPhase3_2TVC ()

@end

@implementation WorkoutListDoublesPhase3_2TVC

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
                            self.cell10,
                            self.cell11];
    NSArray *accessoryIcon = @[@YES,
                                @YES,
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
        
        return 2;
    }
    
    else if (section == 2) {
        
        return 1;
    }
    
    else if (section == 3) {
        
        return 2;
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
    
    // Week 10
    if ([week isEqualToString:@"Week 10"]) {
        
        if (indexPath.section == 0) {
            
            if (indexPath.row == 0) {
                
                // Full on Cardio 14
                ((DataNavController *)self.parentViewController).index = @14;
                ((DataNavController *)self.parentViewController).workout = workoutArray[0];
            }
            
            else if (indexPath.row == 1) {
                
                // Chest + Shoulders + Tri 4
                ((DataNavController *)self.parentViewController).index = @4;
                ((DataNavController *)self.parentViewController).workout = workoutArray[1];
            }
        }
        
        else if (indexPath.section == 1) {
            
            if (indexPath.row == 0) {
                
                // Full on Cardio 15
                ((DataNavController *)self.parentViewController).index = @15;
                ((DataNavController *)self.parentViewController).workout = workoutArray[2];
            }

            else if (indexPath.row == 1) {
                
                // Plyometrics 8
                ((DataNavController *)self.parentViewController).index = @8;
                ((DataNavController *)self.parentViewController).workout = workoutArray[3];
            }
        }
        
        else if (indexPath.section == 2) {
            
            if (indexPath.row == 1) {
                
                // Back + Biceps 4
                ((DataNavController *)self.parentViewController).index = @4;
                ((DataNavController *)self.parentViewController).workout = workoutArray[4];
            }
        }
        
        else if (indexPath.section == 3) {
            
            if (indexPath.row == 0) {
                
                // Full on Cardio 16
                ((DataNavController *)self.parentViewController).index = @16;
                ((DataNavController *)self.parentViewController).workout = workoutArray[5];
            }
            
            else if (indexPath.row == 1) {
                
                // Yoga 12
                ((DataNavController *)self.parentViewController).index = @12;
                ((DataNavController *)self.parentViewController).workout = workoutArray[6];
            }
        }
        
        else if (indexPath.section == 4) {
            
            if (indexPath.row == 0) {
                
                // Full on Cardio 17
                ((DataNavController *)self.parentViewController).index = @17;
                ((DataNavController *)self.parentViewController).workout = workoutArray[7];
            }
            
            else if (indexPath.row == 1) {
                
                // Legs + Back 8
                ((DataNavController *)self.parentViewController).index = @8;
                ((DataNavController *)self.parentViewController).workout = workoutArray[8];
            }
        }
        
        else if (indexPath.section == 5) {
            
            if (indexPath.row == 0) {
                
                // Judo Chop 10
                ((DataNavController *)self.parentViewController).index = @10;
                ((DataNavController *)self.parentViewController).workout = workoutArray[9];
            }
        }
        
        else if (indexPath.section == 6) {
            
            if (indexPath.row == 0) {
                
                // Stretch 12
                ((DataNavController *)self.parentViewController).index = @12;
                ((DataNavController *)self.parentViewController).workout = workoutArray[10];
            }
        }
    }
    
    // Week 12
    else if ([week isEqualToString:@"Week 12"]) {
        
        if (indexPath.section == 0) {
            
            if (indexPath.row == 0) {
                
                // Full on Cardio 22
                ((DataNavController *)self.parentViewController).index = @22;
                ((DataNavController *)self.parentViewController).workout = workoutArray[0];
            }
            
            else if (indexPath.row == 1) {
                
                // Chest + Shoulders + Tri 5
                ((DataNavController *)self.parentViewController).index = @5;
                ((DataNavController *)self.parentViewController).workout = workoutArray[1];
            }
        }
        
        else if (indexPath.section == 1) {
            
            if (indexPath.row == 0) {
                
                // Full on Cardio 23
                ((DataNavController *)self.parentViewController).index = @23;
                ((DataNavController *)self.parentViewController).workout = workoutArray[2];
            }
            
            else if (indexPath.row == 1) {
                
                // Plyometrics 10
                ((DataNavController *)self.parentViewController).index = @10;
                ((DataNavController *)self.parentViewController).workout = workoutArray[3];
            }
        }
        
        else if (indexPath.section == 2) {
            
            if (indexPath.row == 1) {
                
                // Back + Biceps 5
                ((DataNavController *)self.parentViewController).index = @5;
                ((DataNavController *)self.parentViewController).workout = workoutArray[4];
            }
        }
        
        else if (indexPath.section == 3) {
            
            if (indexPath.row == 0) {
                
                // Full on Cardio 24
                ((DataNavController *)self.parentViewController).index = @24;
                ((DataNavController *)self.parentViewController).workout = workoutArray[5];
            }
            
            else if (indexPath.row == 1) {
                
                // Yoga 14
                ((DataNavController *)self.parentViewController).index = @14;
                ((DataNavController *)self.parentViewController).workout = workoutArray[6];
            }
        }
        
        else if (indexPath.section == 4) {
            
            if (indexPath.row == 0) {
                
                // Full on Cardio 25
                ((DataNavController *)self.parentViewController).index = @25;
                ((DataNavController *)self.parentViewController).workout = workoutArray[7];
            }
            
            else if (indexPath.row == 1) {
                
                // Legs + Back 10
                ((DataNavController *)self.parentViewController).index = @10;
                ((DataNavController *)self.parentViewController).workout = workoutArray[8];
            }
        }
        
        else if (indexPath.section == 5) {
            
            if (indexPath.row == 0) {
                
                // Judo Chop 12
                ((DataNavController *)self.parentViewController).index = @12;
                ((DataNavController *)self.parentViewController).workout = workoutArray[9];
            }
        }
        
        else if (indexPath.section == 6) {
            
            if (indexPath.row == 0) {
                
                // Stretch 14
                ((DataNavController *)self.parentViewController).index = @14;
                ((DataNavController *)self.parentViewController).workout = workoutArray[10];
            }
        }
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *routineWeek;
    
    if (section == 0) {
        
        routineWeek = [((DataNavController *)self.parentViewController).routine stringByAppendingFormat:@" - %@ - Day %d", ((DataNavController *)self.parentViewController).week, section + 1];
    }
    
    else if (section == 1) {
        
        routineWeek = [((DataNavController *)self.parentViewController).routine stringByAppendingFormat:@" - %@ - Day %d", ((DataNavController *)self.parentViewController).week, section + 1];
    }
    
    else if (section == 2) {
        
        routineWeek = [((DataNavController *)self.parentViewController).routine stringByAppendingFormat:@" - %@ - Day %d", ((DataNavController *)self.parentViewController).week, section + 1];
    }
    
    else if (section == 3) {
        
        routineWeek = [((DataNavController *)self.parentViewController).routine stringByAppendingFormat:@" - %@ - Day %d", ((DataNavController *)self.parentViewController).week, section + 1];
    }
    
    else if (section == 4) {
        
        routineWeek = [((DataNavController *)self.parentViewController).routine stringByAppendingFormat:@" - %@ - Day %d", ((DataNavController *)self.parentViewController).week, section + 1];
    }
    
    else if (section == 5) {
        
        routineWeek = [((DataNavController *)self.parentViewController).routine stringByAppendingFormat:@" - %@ - Day %d", ((DataNavController *)self.parentViewController).week, section + 1];
    }
    
    else {
        
        routineWeek = [((DataNavController *)self.parentViewController).routine stringByAppendingFormat:@" - %@ - Day %d", ((DataNavController *)self.parentViewController).week, section + 1];
    }
    
    return routineWeek;
}
@end
