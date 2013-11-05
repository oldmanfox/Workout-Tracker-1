//
//  WorkoutListLeanPhase2TVC.m
//  90 DWT 1
//
//  Created by Jared Grant on 7/13/12.
//  Copyright (c) 2012 g-rantsoftware.com. All rights reserved.
//

#import "WorkoutListLeanPhase2TVC.h"

@interface WorkoutListLeanPhase2TVC ()

@end

@implementation WorkoutListLeanPhase2TVC

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
                            self.cell7];
    NSArray *accessoryIcon = @[@YES,
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 7;
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
    
    workoutArray = @[@"Core Fitness",
                    @"Full on Cardio",
                    @"Shoulders + Arms & Ab Workout",
                    @"Yoga",
                    @"Legs + Back & Ab Workout",
                    @"Judo Chop",
                    @"Stretch or Rest"];
    ((DataNavController *)self.parentViewController).workout = workoutArray[indexPath.row];
    
    // Week 5
    if ([week isEqualToString:@"Week 5"]) {
        
        if (indexPath.row == 0) {
            
            // Core Fitness 6
            ((DataNavController *)self.parentViewController).index = @6;
        }
        
        else if (indexPath.row == 1) {
            
            // Full on Cardio 4
            ((DataNavController *)self.parentViewController).index = @4;
        }
        
        else if (indexPath.row == 2) {
            
            // Chest + Shoulders + Tri 1
            ((DataNavController *)self.parentViewController).index = @1;
        }
        
        else if (indexPath.row == 3) {
            
            // Yoga 6
            ((DataNavController *)self.parentViewController).index = @6;
        }
        
        else if (indexPath.row == 4) {
            
            // Legs + Back 4
            ((DataNavController *)self.parentViewController).index = @4;
        }
        
        else if (indexPath.row == 5) {
            
            // Judo Chop 5
            ((DataNavController *)self.parentViewController).index = @5;
        }
        
        else if (indexPath.row == 6) {
            
            // Stretch 6
            ((DataNavController *)self.parentViewController).index = @6;
        }
    }
    
    // Week 6
    else if ([week isEqualToString:@"Week 6"]) {
        
        if (indexPath.row == 0) {
            
            // Core Fitness 7
            ((DataNavController *)self.parentViewController).index = @7;
        }
        
        else if (indexPath.row == 1) {
            
            // Full on Cardio 5
            ((DataNavController *)self.parentViewController).index = @5;
        }
        
        else if (indexPath.row == 2) {
            
            // Chest + Shoulders + Tri 2
            ((DataNavController *)self.parentViewController).index = @2;
        }
        
        else if (indexPath.row == 3) {
            
            // Yoga 7
            ((DataNavController *)self.parentViewController).index = @7;
        }
        
        else if (indexPath.row == 4) {
            
            // Legs + Back 5
            ((DataNavController *)self.parentViewController).index = @5;
        }
        
        else if (indexPath.row == 5) {
            
            // Judo Chop 6
            ((DataNavController *)self.parentViewController).index = @6;
        }
        
        else if (indexPath.row == 6) {
            
            // Stretch 7
            ((DataNavController *)self.parentViewController).index = @7;
        }
    }
    
    // Week 7
    else if ([week isEqualToString:@"Week 7"]) {
        
        if (indexPath.row == 0) {
            
            // Core Fitness 8
            ((DataNavController *)self.parentViewController).index = @8;
            
        }
        
        else if (indexPath.row == 1) {
            
            // Full on Cardio 6
            ((DataNavController *)self.parentViewController).index = @6;
        }
        
        else if (indexPath.row == 2) {
            
            // Chest + Shoulders + Tri 3
            ((DataNavController *)self.parentViewController).index = @3;
        }
        
        else if (indexPath.row == 3) {
            
            // Yoga 8
            ((DataNavController *)self.parentViewController).index = @8;
        }
        
        else if (indexPath.row == 4) {
            
            // Legs + Back 6
            ((DataNavController *)self.parentViewController).index = @6;
        }
        
        else if (indexPath.row == 5) {
            
            // Judo Chop 7
            ((DataNavController *)self.parentViewController).index = @7;
        }
        
        else if (indexPath.row == 6) {
            
            // Stretch 8
            ((DataNavController *)self.parentViewController).index = @8;
        }
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section ==0) {
        
        NSString *routineWeek = [((DataNavController *)self.parentViewController).routine stringByAppendingFormat:@" - %@", ((DataNavController *)self.parentViewController).week];
        return routineWeek;
    }
    
    else {
        
        return @"";
    }
}
@end
