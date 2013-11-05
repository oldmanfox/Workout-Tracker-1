//
//  WorkoutListLeanPhase1TVC.m
//  i90X
//
//  Created by Jared Grant on 7/13/12.
//  Copyright (c) 2012 g-rantsoftware.com. All rights reserved.
//

#import "WorkoutListLeanPhase1TVC.h"

@interface WorkoutListLeanPhase1TVC ()

@end

@implementation WorkoutListLeanPhase1TVC
@synthesize cell1;
@synthesize cell2;
@synthesize cell3;
@synthesize cell4;
@synthesize cell5;
@synthesize cell6;
@synthesize cell7;

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

- (void)viewDidUnload
{
    [self setCell1:nil];
    [self setCell2:nil];
    [self setCell3:nil];
    [self setCell4:nil];
    [self setCell5:nil];
    [self setCell6:nil];
    [self setCell7:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
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
    
    workoutArray = [[NSArray alloc] initWithObjects:@"Core Synergistics",
                    @"Cardio X",
                    @"Shoulders + Arms",
                    @"Yoga X",
                    @"Legs + Back",
                    @"Kenpo X",
                    @"X Stretch",
                    nil];
    
    // Week 1
    if ([week isEqualToString:@"Week 1"]) {
        
        if (indexPath.row == 0) {
            
            // Core Synergistics 1
            ((DataNavController *)self.parentViewController).index = [NSNumber numberWithInt:1];
        }
        
        else if (indexPath.row == 1) {
            
            // Cardio X 1
            ((DataNavController *)self.parentViewController).index = [NSNumber numberWithInt:1];
        }
        
        else if (indexPath.row == 2) {
            
            // Shoulders + Arms 1
            ((DataNavController *)self.parentViewController).index = [NSNumber numberWithInt:1];
        }
        
        else if (indexPath.row == 3) {
            
            // Yoga X 1
            ((DataNavController *)self.parentViewController).index = [NSNumber numberWithInt:1];
        }
        
        else if (indexPath.row == 4) {
            
            // Legs + Back 1
            ((DataNavController *)self.parentViewController).index = [NSNumber numberWithInt:1];
        }
        
        else if (indexPath.row == 5) {
            
            // Kenpo X 1
            ((DataNavController *)self.parentViewController).index = [NSNumber numberWithInt:1];
        }
        
        else if (indexPath.row == 6) {
            
            // X Stretch 1
            ((DataNavController *)self.parentViewController).index = [NSNumber numberWithInt:1];
        }
    }
    
    // Week 2
    else if ([week isEqualToString:@"Week 2"]) {
        
        if (indexPath.row == 0) {
            
            // Core Synergistics 2
            ((DataNavController *)self.parentViewController).index = [NSNumber numberWithInt:2];
        }
        
        else if (indexPath.row == 1) {
            
            // Cardio X 2
            ((DataNavController *)self.parentViewController).index = [NSNumber numberWithInt:2];
        }
        
        else if (indexPath.row == 2) {
            
            // Shoulders + Arms 2
            ((DataNavController *)self.parentViewController).index = [NSNumber numberWithInt:2];
        }
        
        else if (indexPath.row == 3) {
            
            // Yoga X 2
            ((DataNavController *)self.parentViewController).index = [NSNumber numberWithInt:2];
        }
        
        else if (indexPath.row == 4) {
            
            // Legs + Back 2
            ((DataNavController *)self.parentViewController).index = [NSNumber numberWithInt:2];
        }
        
        else if (indexPath.row == 5) {
            
            // Kenpo X 2
            ((DataNavController *)self.parentViewController).index = [NSNumber numberWithInt:2];
        }
        
        else if (indexPath.row == 6) {
            
            // X Stretch 2
            ((DataNavController *)self.parentViewController).index = [NSNumber numberWithInt:2];
        }
    }
    
    // Week 3
    else if ([week isEqualToString:@"Week 3"]) {
        
        if (indexPath.row == 0) {
            
            // Core Synergistics 3
            ((DataNavController *)self.parentViewController).index = [NSNumber numberWithInt:3];

        }
        
        else if (indexPath.row == 1) {
            
            // Cardio X 3
            ((DataNavController *)self.parentViewController).index = [NSNumber numberWithInt:3];
        }
        
        else if (indexPath.row == 2) {
            
            // Shoulders + Arms 3
            ((DataNavController *)self.parentViewController).index = [NSNumber numberWithInt:3];
        }
        
        else if (indexPath.row == 3) {
            
            // Yoga X 3
            ((DataNavController *)self.parentViewController).index = [NSNumber numberWithInt:3];
        }
        
        else if (indexPath.row == 4) {
            
            // Legs + Back 3
            ((DataNavController *)self.parentViewController).index = [NSNumber numberWithInt:3];
        }
        
        else if (indexPath.row == 5) {
            
            // Kenpo X 3
            ((DataNavController *)self.parentViewController).index = [NSNumber numberWithInt:3];
        }
        
        else if (indexPath.row == 6) {
            
            // X Stretch 3
            ((DataNavController *)self.parentViewController).index = [NSNumber numberWithInt:3];
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
    
    // Accessory view icon
    UIImage* accessory = [UIImage imageNamed:@"icon-arrow-blue.png"];
    UIImageView* accessoryView1 = [[UIImageView alloc] initWithImage:accessory];
    UIImageView* accessoryView2 = [[UIImageView alloc] initWithImage:accessory];
    UIImageView* accessoryView3 = [[UIImageView alloc] initWithImage:accessory];
    UIImageView* accessoryView4 = [[UIImageView alloc] initWithImage:accessory];
    UIImageView* accessoryView5 = [[UIImageView alloc] initWithImage:accessory];
    UIImageView* accessoryView6 = [[UIImageView alloc] initWithImage:accessory];
    UIImageView* accessoryView7 = [[UIImageView alloc] initWithImage:accessory];
    
    cell1.accessoryView = accessoryView1;
    cell2.accessoryView = accessoryView2;
    cell3.accessoryView = accessoryView3;
    cell4.accessoryView = accessoryView4;
    cell5.accessoryView = accessoryView5;
    cell6.accessoryView = accessoryView6;
    cell7.accessoryView = accessoryView7;
}
@end
