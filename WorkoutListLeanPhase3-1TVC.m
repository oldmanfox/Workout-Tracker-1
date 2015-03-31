//
//  WorkoutListLeanPhase3-1TVC.m
//  90 DWT 1
//
//  Created by Jared Grant on 7/14/12.
//  Copyright (c) 2012 g-rantsoftware.com. All rights reserved.
//

#import "WorkoutListLeanPhase3-1TVC.h"
#import "DWT1IAPHelper.h"

@interface WorkoutListLeanPhase3_1TVC ()

@end

@implementation WorkoutListLeanPhase3_1TVC

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
    
    workoutArray = @[@"Chest + Back & Ab Workout",
                    @"Full on Cardio",
                    @"Shoulders + Arms & Ab Workout",
                    @"Yoga",
                    @"Core Fitness",
                    @"Judo Chop",
                    @"Stretch or Rest"];
    ((DataNavController *)self.parentViewController).workout = workoutArray[indexPath.row];
    
    // Week 9
    if ([week isEqualToString:@"Week 9"]) {
        
        if (indexPath.row == 0) {
            
            // Chest + Back 1
            ((DataNavController *)self.parentViewController).index = @1;
        }
        
        else if (indexPath.row == 1) {
            
            // Full on Cardio 8
            ((DataNavController *)self.parentViewController).index = @8;
        }
        
        else if (indexPath.row == 2) {
            
            // Shoulders + Arms 4
            ((DataNavController *)self.parentViewController).index = @4;
        }
        
        else if (indexPath.row == 3) {
            
            // Yoga 11
            ((DataNavController *)self.parentViewController).index = @11;
        }
        
        else if (indexPath.row == 4) {
            
            // Core Fitness 10
            ((DataNavController *)self.parentViewController).index = @10;
        }
        
        else if (indexPath.row == 5) {
            
            // Judo Chop 9
            ((DataNavController *)self.parentViewController).index = @9;
        }
        
        else if (indexPath.row == 6) {
            
            // Stretch 11
            ((DataNavController *)self.parentViewController).index = @11;
        }
    }
    
    // Week 11
    else if ([week isEqualToString:@"Week 11"]) {
        
        if (indexPath.row == 0) {
            
            // Chest + Back 2
            ((DataNavController *)self.parentViewController).index = @2;
        }
        
        else if (indexPath.row == 1) {
            
            // Full on Cardio 10
            ((DataNavController *)self.parentViewController).index = @10;
        }
        
        else if (indexPath.row == 2) {
            
            // Shoulders + Arms 5
            ((DataNavController *)self.parentViewController).index = @5;
        }
        
        else if (indexPath.row == 3) {
            
            // Yoga 13
            ((DataNavController *)self.parentViewController).index = @13;
        }
        
        else if (indexPath.row == 4) {
            
            // Core Fitness 12
            ((DataNavController *)self.parentViewController).index = @12;
        }
        
        else if (indexPath.row == 5) {
            
            // Judo Chop 11
            ((DataNavController *)self.parentViewController).index = @11;
        }
        
        else if (indexPath.row == 6) {
            
            // Stretch 13
            ((DataNavController *)self.parentViewController).index = @13;
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
