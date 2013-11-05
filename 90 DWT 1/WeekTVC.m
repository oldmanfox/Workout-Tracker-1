//
//  WeekTVC.m
//  i90X
//
//  Created by Jared Grant on 7/11/12.
//  Copyright (c) 2012 g-rantsoftware.com. All rights reserved.
//

#import "WeekTVC.h"

@interface WeekTVC ()

@end

@implementation WeekTVC
@synthesize cell1;
@synthesize cell2;
@synthesize cell3;
@synthesize cell4;
@synthesize cell5;
@synthesize cell6;
@synthesize cell7;
@synthesize cell8;
@synthesize cell9;
@synthesize cell10;
@synthesize cell11;
@synthesize cell12;
@synthesize cell13;

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
    [self configureTableView];
}

- (void)viewDidAppear:(BOOL)animated {
    // Get path to documents directory
    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex: 0];
    NSString *defaultWorkoutFile = nil;
    defaultWorkoutFile = [docDir stringByAppendingPathComponent:@"Default Workout.out"];
    
    if  ([[NSFileManager defaultManager] fileExistsAtPath:defaultWorkoutFile]) {
        NSFileHandle *fileHandle = [NSFileHandle fileHandleForReadingAtPath:defaultWorkoutFile];
        self.navigationItem.title = [[NSString alloc] initWithData:[fileHandle availableData] encoding:NSUTF8StringEncoding];
        [fileHandle closeFile];
    }
    ((DataNavController *)self.parentViewController).routine = self.navigationItem.title;
}

- (void)viewDidUnload
{
    [self setCell1:nil];
    [self setCell2:nil];
    [self setCell3:nil];
    [self setCell4:nil];
    [self setCell5:nil];
    [self setCell6:nil];
    [self setCell7:nil];
    [self setCell8:nil];
    [self setCell9:nil];
    [self setCell10:nil];
    [self setCell11:nil];
    [self setCell12:nil];
    [self setCell13:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
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
    
    // Phase 1
    if (indexPath.section == 0) {
        
        ((DataNavController *)self.parentViewController).phase = @"Phase 1";
        
        // Segue to normal workout list if week 1-3 is selected.
        // Segue to recovery workout list if week 4 is selected.
        if (indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 2) {
            
            workoutSegueName = [workoutSegueName stringByAppendingString:@" 1-3"];
        }
        
        else {
            
            workoutSegueName = @"Recovery";
        }
        
        // Get current week
        for (int i = 0; i < 4; i++) {
                       
            if (indexPath.row == i) {
                
                selectedWeek = [selectedWeek stringByAppendingFormat:@" %d", i + 1];
            }
        }
    }
    
    // Phase 2
    else if (indexPath.section == 1) {
        
        ((DataNavController *)self.parentViewController).phase = @"Phase 2";
        
        // Segue to normal workout list if week 5-7 is selected.
        // Segue to recovery workout list if week 8 is selected.
        if (indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 2) {
            
            workoutSegueName = [workoutSegueName stringByAppendingString:@" 5-7"];
        }
        
        else {
            
            workoutSegueName = @"Recovery";
        }

        // Get current week
        for (int i = 0; i < 4; i++) {
            
            if (indexPath.row == i) {
                
                selectedWeek = [selectedWeek stringByAppendingFormat:@" %d", i + 5];
            }
        }
    }
    
    // Phase 3
    else {
        
        ((DataNavController *)self.parentViewController).phase = @"Phase 3";
        
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
            
            workoutSegueName = @"Recovery";
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
    if ([segue.identifier isEqualToString:@"Recovery"]) {
        
        if ([((DataNavController *)self.parentViewController).routine isEqualToString:@"Lean"]) {
            
            if ([((DataNavController *)self.parentViewController).week isEqualToString:@"Week 8"] || [((DataNavController *)self.parentViewController).week isEqualToString:@"Week 13"]) {
                
                ((DataNavController *)self.parentViewController).recoveryCell5 = @"Cardio X";
            }
            
            else {
                
                ((DataNavController *)self.parentViewController).recoveryCell5 = @"Core Synergistics";
            }
        }
        
        else {
            
            ((DataNavController *)self.parentViewController).recoveryCell5 = @"Core Synergistics";
        }
    }
}

- (void)configureTableView {
    UIImage *backgroundImage;
    UIColor *backgroundColor;
    UIImage *cellbackgroundImage;
    UIColor *cellbackgroundColor;
    
    [self.tableView setBackgroundView:nil];
    [self.tableView setBackgroundView:[[UIView alloc] init]];
    
    [self.tableView setBackgroundColor:[UIColor clearColor]]; // this is for iPhone
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] != UIUserInterfaceIdiomPhone) {
        // iPad
        backgroundImage = [UIImage imageNamed:@"background-iPad-chrome.png"];
        backgroundColor = [UIColor colorWithPatternImage:backgroundImage];
        
        cellbackgroundImage = [UIImage imageNamed:@"tableviewcell-iPad-chrome.png"];
        cellbackgroundColor = [UIColor colorWithPatternImage:cellbackgroundImage];
        
    }
    else {
        // iPhone
        backgroundImage = [UIImage imageNamed:@"background-iPhone-chrome.png"];
        backgroundColor = [UIColor colorWithPatternImage:backgroundImage];
        
        cellbackgroundImage = [UIImage imageNamed:@"tableviewcell-iPhone-chrome.png"];
        cellbackgroundColor = [UIColor colorWithPatternImage:cellbackgroundImage];
    }
    
    // TableView background color
    self.tableView.backgroundColor = backgroundColor;
    
    // Cell background color
    cell1.backgroundColor = cellbackgroundColor;
    cell2.backgroundColor = cellbackgroundColor;
    cell3.backgroundColor = cellbackgroundColor;
    cell4.backgroundColor = cellbackgroundColor;
    cell5.backgroundColor = cellbackgroundColor;
    cell6.backgroundColor = cellbackgroundColor;
    cell7.backgroundColor = cellbackgroundColor;
    cell8.backgroundColor = cellbackgroundColor;
    cell9.backgroundColor = cellbackgroundColor;
    cell10.backgroundColor = cellbackgroundColor;
    cell11.backgroundColor = cellbackgroundColor;
    cell12.backgroundColor = cellbackgroundColor;
    cell13.backgroundColor = cellbackgroundColor;
    
    // Label backgrounds
    cell1.textLabel.backgroundColor = [UIColor clearColor];
    cell1.detailTextLabel.backgroundColor = [UIColor clearColor];
    
    cell2.textLabel.backgroundColor = [UIColor clearColor];
    cell2.detailTextLabel.backgroundColor = [UIColor clearColor];
    
    cell3.textLabel.backgroundColor = [UIColor clearColor];
    cell3.detailTextLabel.backgroundColor = [UIColor clearColor];

    cell4.textLabel.backgroundColor = [UIColor clearColor];
    cell4.detailTextLabel.backgroundColor = [UIColor clearColor];
    
    cell5.textLabel.backgroundColor = [UIColor clearColor];
    cell5.detailTextLabel.backgroundColor = [UIColor clearColor];
    
    cell6.textLabel.backgroundColor = [UIColor clearColor];
    cell6.detailTextLabel.backgroundColor = [UIColor clearColor];
    
    cell7.textLabel.backgroundColor = [UIColor clearColor];
    cell7.detailTextLabel.backgroundColor = [UIColor clearColor];
    
    cell8.textLabel.backgroundColor = [UIColor clearColor];
    cell8.detailTextLabel.backgroundColor = [UIColor clearColor];
    
    cell9.textLabel.backgroundColor = [UIColor clearColor];
    cell9.detailTextLabel.backgroundColor = [UIColor clearColor];
    
    cell10.textLabel.backgroundColor = [UIColor clearColor];
    cell10.detailTextLabel.backgroundColor = [UIColor clearColor];
    
    cell11.textLabel.backgroundColor = [UIColor clearColor];
    cell11.detailTextLabel.backgroundColor = [UIColor clearColor];
    
    cell12.textLabel.backgroundColor = [UIColor clearColor];
    cell12.detailTextLabel.backgroundColor = [UIColor clearColor];
    
    cell13.textLabel.backgroundColor = [UIColor clearColor];
    cell13.detailTextLabel.backgroundColor = [UIColor clearColor];

    // Accessory view icon
    UIImage* accessory = [UIImage imageNamed:@"icon-arrow-blue.png"];
    UIImageView* accessoryView1 = [[UIImageView alloc] initWithImage:accessory];
    UIImageView* accessoryView2 = [[UIImageView alloc] initWithImage:accessory];
    UIImageView* accessoryView3 = [[UIImageView alloc] initWithImage:accessory];
    UIImageView* accessoryView4 = [[UIImageView alloc] initWithImage:accessory];
    UIImageView* accessoryView5 = [[UIImageView alloc] initWithImage:accessory];
    UIImageView* accessoryView6 = [[UIImageView alloc] initWithImage:accessory];
    UIImageView* accessoryView7 = [[UIImageView alloc] initWithImage:accessory];
    UIImageView* accessoryView8 = [[UIImageView alloc] initWithImage:accessory];
    UIImageView* accessoryView9 = [[UIImageView alloc] initWithImage:accessory];
    UIImageView* accessoryView10 = [[UIImageView alloc] initWithImage:accessory];
    UIImageView* accessoryView11 = [[UIImageView alloc] initWithImage:accessory];
    UIImageView* accessoryView12 = [[UIImageView alloc] initWithImage:accessory];
    UIImageView* accessoryView13 = [[UIImageView alloc] initWithImage:accessory];
    
    cell1.accessoryView = accessoryView1;
    cell2.accessoryView = accessoryView2;
    cell3.accessoryView = accessoryView3;
    cell4.accessoryView = accessoryView4;
    cell5.accessoryView = accessoryView5;
    cell6.accessoryView = accessoryView6;
    cell7.accessoryView = accessoryView7;
    cell8.accessoryView = accessoryView8;
    cell9.accessoryView = accessoryView9;
    cell10.accessoryView = accessoryView10;
    cell11.accessoryView = accessoryView11;
    cell12.accessoryView = accessoryView12;
    cell13.accessoryView = accessoryView13;
}
@end
