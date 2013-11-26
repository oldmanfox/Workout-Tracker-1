//
//  WorkoutListClassicPhase3-2TVC.m
//  90 DWT 1
//
//  Created by Jared Grant on 7/14/12.
//  Copyright (c) 2012 g-rantsoftware.com. All rights reserved.
//

#import "WorkoutListClassicPhase3-2TVC.h"

@interface WorkoutListClassicPhase3_2TVC ()

@end

@implementation WorkoutListClassicPhase3_2TVC

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
    
    workoutArray = @[@"Chest + Shoulders + Tri & Ab Workout", 
                    @"Plyometrics", 
                    @"Back + Biceps & Ab Workout", 
                    @"Yoga", 
                    @"Legs + Back & Ab Workout", 
                    @"Judo Chop", 
                    @"Stretch or Rest"];
    ((DataNavController *)self.parentViewController).workout = workoutArray[indexPath.row];
    
    // Week 10
    if ([week isEqualToString:@"Week 10"]) {
        
        if (indexPath.row == 0) {
            
            // Chest + Shoulders + Tri 4
            ((DataNavController *)self.parentViewController).index = @4;
        }
        
        else if (indexPath.row == 1) {
            
            // Plyometrics 8
            ((DataNavController *)self.parentViewController).index = @8;
        }
        
        else if (indexPath.row == 2) {
            
            // Back + Biceps 4
            ((DataNavController *)self.parentViewController).index = @4;
        }
        
        else if (indexPath.row == 3) {
            
            // Yoga 12
            ((DataNavController *)self.parentViewController).index = @12;
        }
        
        else if (indexPath.row == 4) {
            
            // Legs + Back 8
            ((DataNavController *)self.parentViewController).index = @8;
        }
        
        else if (indexPath.row == 5) {
            
            // Judo Chop 10
            ((DataNavController *)self.parentViewController).index = @10;
        }
        
        else if (indexPath.row == 6) {
            
            // Stretch 12
            ((DataNavController *)self.parentViewController).index = @12;
        }
    }
    
    // Week 12
    else if ([week isEqualToString:@"Week 12"]) {
        
        if (indexPath.row == 0) {
            
            // Chest + Shoulders + Tri 5
            ((DataNavController *)self.parentViewController).index = @5;
        }
        
        else if (indexPath.row == 1) {
            
            // Plyometrics 10
            ((DataNavController *)self.parentViewController).index = @10;
        }
        
        else if (indexPath.row == 2) {
            
            // Back + Biceps 5
            ((DataNavController *)self.parentViewController).index = @5;
        }
        
        else if (indexPath.row == 3) {
            
            // Yoga 14
            ((DataNavController *)self.parentViewController).index = @14;
        }
        
        else if (indexPath.row == 4) {
            
            // Legs + Back 10
            ((DataNavController *)self.parentViewController).index = @10;
        }
        
        else if (indexPath.row == 5) {
            
            // Judo Chop 12
            ((DataNavController *)self.parentViewController).index = @12;
        }
        
        else if (indexPath.row == 6) {
            
            // Stretch 14
            ((DataNavController *)self.parentViewController).index = @14;
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
