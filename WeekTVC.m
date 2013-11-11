//
//  WeekTVC.m
//  90 DWT 1
//
//  Created by Jared Grant on 7/11/12.
//  Copyright (c) 2012 g-rantsoftware.com. All rights reserved.
//

#import "WeekTVC.h"

@interface WeekTVC ()

@end

@implementation WeekTVC

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
                            self.cell11,
                            self.cell12,
                            self.cell13];
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
                                @YES,
                                @YES,
                                @YES];
    //[self configureTableView:tableCell :accessoryIcon];
}

- (void)viewDidAppear:(BOOL)animated {
    
    // Get path to documents directory
    NSString *docDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *defaultWorkoutFile = nil;
    defaultWorkoutFile = [docDir stringByAppendingPathComponent:@"Default Workout.out"];
    
    if  ([[NSFileManager defaultManager] fileExistsAtPath:defaultWorkoutFile]) {
        
        // File has already been created. Get value of routine from it.
        NSFileHandle *fileHandle = [NSFileHandle fileHandleForReadingAtPath:defaultWorkoutFile];
        self.navigationItem.title = [[NSString alloc] initWithData:[fileHandle availableData] encoding:NSUTF8StringEncoding];
        [fileHandle closeFile];
        
        ((DataNavController *)self.parentViewController).routine = self.navigationItem.title;
    }
    
    else {
        
        // File has not been created so this is the first time the app has been opened or user has not changed workout.
        ((DataNavController *)self.parentViewController).routine = @"Normal";
        self.navigationItem.title = ((DataNavController *)self.parentViewController).routine;
    }
    
    //NSLog(@"Routine = %@", ((DataNavController *)self.parentViewController).routine);
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source


#pragma mark - Table view delegate


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *selectedWeek = @"Week";
    NSString *workoutSegueName = self.navigationItem.title;
    
    // Month 1
    if (indexPath.section == 0) {
        
        ((DataNavController *)self.parentViewController).month = @"Month 1";
        
        // Segue to normal workout list if week 1-3 is selected.
        // Segue to recovery workout list if week 4 is selected.
        if (indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 2) {
            
            workoutSegueName = [workoutSegueName stringByAppendingString:@" 1-3"];
        }
        
        else {
            
            workoutSegueName = @"Light";
        }
        
        // Get current week
        for (int i = 0; i < 4; i++) {
                       
            if (indexPath.row == i) {
                
                selectedWeek = [selectedWeek stringByAppendingFormat:@" %d", i + 1];
            }
        }
    }
    
    // Month 2
    else if (indexPath.section == 1) {
        
        ((DataNavController *)self.parentViewController).month = @"Month 2";
        
        // Segue to normal workout list if week 5-7 is selected.
        // Segue to recovery workout list if week 8 is selected.
        if (indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 2) {
            
            workoutSegueName = [workoutSegueName stringByAppendingString:@" 5-7"];
        }
        
        else {
            
            workoutSegueName = @"Light";
        }

        // Get current week
        for (int i = 0; i < 4; i++) {
            
            if (indexPath.row == i) {
                
                selectedWeek = [selectedWeek stringByAppendingFormat:@" %d", i + 5];
            }
        }
    }
    
    // Month 3
    else {
        
        ((DataNavController *)self.parentViewController).month = @"Month 3";
        
        // Segue to workout 1 list if week 9 or 11 is selected.
        // Segue to workout 2 list if week 10 or 12 is selected.
        // Segue to recovery workout list if week 13 is selected.
        if (indexPath.row == 0 || indexPath.row == 2) {
            
            workoutSegueName = [workoutSegueName stringByAppendingString:@" 9+11"];
        }
        
        else if (indexPath.row == 1 || indexPath.row == 3) {
            
            workoutSegueName = [workoutSegueName stringByAppendingString:@" 10+12"];
        }
        
        else {
            
            workoutSegueName = @"Light";
        }

        // Get current week
        for (int i = 0; i < 5; i++) {
            
            if (indexPath.row == i) {
                
                selectedWeek = [selectedWeek stringByAppendingFormat:@" %d", i + 9];
            }
        }
    }
    
    ((DataNavController *)self.parentViewController).week = selectedWeek;
    
    [self performSegueWithIdentifier:workoutSegueName sender:self];    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    // Chnage the default RecoveryTVC's cell5 during Lean's week 8 and 13.
    if ([segue.identifier isEqualToString:@"Light"]) {
        
        if ([((DataNavController *)self.parentViewController).routine isEqualToString:@"Tone"]) {
            
            if ([((DataNavController *)self.parentViewController).week isEqualToString:@"Week 8"] || [((DataNavController *)self.parentViewController).week isEqualToString:@"Week 13"]) {
                
                ((DataNavController *)self.parentViewController).lightCell5 = @"Full on Cardio";
            }
            
            else {
                
                ((DataNavController *)self.parentViewController).lightCell5 = @"Core Fitness";
            }
        }
        
        else {
            
            ((DataNavController *)self.parentViewController).lightCell5 = @"Core Fitness";
        }
    }
}
@end
