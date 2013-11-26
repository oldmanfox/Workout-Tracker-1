//
//  WorkoutListLeanPhase1TVC.m
//  90 DWT 1
//
//  Created by Jared Grant on 7/13/12.
//  Copyright (c) 2012 g-rantsoftware.com. All rights reserved.
//

#import "WorkoutListLeanPhase1TVC.h"

@interface WorkoutListLeanPhase1TVC ()

@end

@implementation WorkoutListLeanPhase1TVC

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
    
    // Week 1
    if ([week isEqualToString:@"Week 1"]) {
        
        if (indexPath.row == 0) {
            
            // Core Fitness 1
            ((DataNavController *)self.parentViewController).index = @1;
        }
        
        else if (indexPath.row == 1) {
            
            // Full on Cardio 1
            ((DataNavController *)self.parentViewController).index = @1;
        }
        
        else if (indexPath.row == 2) {
            
            // Shoulders + Arms 1
            ((DataNavController *)self.parentViewController).index = @1;
        }
        
        else if (indexPath.row == 3) {
            
            // Yoga 1
            ((DataNavController *)self.parentViewController).index = @1;
        }
        
        else if (indexPath.row == 4) {
            
            // Legs + Back 1
            ((DataNavController *)self.parentViewController).index = @1;
        }
        
        else if (indexPath.row == 5) {
            
            // Judo Chop 1
            ((DataNavController *)self.parentViewController).index = @1;
        }
        
        else if (indexPath.row == 6) {
            
            // Stretch 1
            ((DataNavController *)self.parentViewController).index = @1;
        }
    }
    
    // Week 2
    else if ([week isEqualToString:@"Week 2"]) {
        
        if (indexPath.row == 0) {
            
            // Core Fitness 2
            ((DataNavController *)self.parentViewController).index = @2;
        }
        
        else if (indexPath.row == 1) {
            
            // Full on Cardio 2
            ((DataNavController *)self.parentViewController).index = @2;
        }
        
        else if (indexPath.row == 2) {
            
            // Shoulders + Arms 2
            ((DataNavController *)self.parentViewController).index = @2;
        }
        
        else if (indexPath.row == 3) {
            
            // Yoga 2
            ((DataNavController *)self.parentViewController).index = @2;
        }
        
        else if (indexPath.row == 4) {
            
            // Legs + Back 2
            ((DataNavController *)self.parentViewController).index = @2;
        }
        
        else if (indexPath.row == 5) {
            
            // Judo Chop 2
            ((DataNavController *)self.parentViewController).index = @2;
        }
        
        else if (indexPath.row == 6) {
            
            // Stretch 2
            ((DataNavController *)self.parentViewController).index = @2;
        }
    }
    
    // Week 3
    else if ([week isEqualToString:@"Week 3"]) {
        
        if (indexPath.row == 0) {
            
            // Core Fitness 3
            ((DataNavController *)self.parentViewController).index = @3;

        }
        
        else if (indexPath.row == 1) {
            
            // Full on Cardio 3
            ((DataNavController *)self.parentViewController).index = @3;
        }
        
        else if (indexPath.row == 2) {
            
            // Shoulders + Arms 3
            ((DataNavController *)self.parentViewController).index = @3;
        }
        
        else if (indexPath.row == 3) {
            
            // Yoga 3
            ((DataNavController *)self.parentViewController).index = @3;
        }
        
        else if (indexPath.row == 4) {
            
            // Legs + Back 3
            ((DataNavController *)self.parentViewController).index = @3;
        }
        
        else if (indexPath.row == 5) {
            
            // Judo Chop 3
            ((DataNavController *)self.parentViewController).index = @3;
        }
        
        else if (indexPath.row == 6) {
            
            // Stretch 3
            ((DataNavController *)self.parentViewController).index = @3;
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
