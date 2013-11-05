//
//  PhotoTVC.m
//  i90X
//
//  Created by Jared Grant on 7/14/12.
//  Copyright (c) 2012 g-rantsoftware.com. All rights reserved.
//

#import "PhotoTVC.h"

@interface PhotoTVC ()

@end

@implementation PhotoTVC
@synthesize cell1;
@synthesize cell2;
@synthesize cell3;
@synthesize cellFinal;
@synthesize cellAll;
@synthesize cellFront;
@synthesize cellSide;
@synthesize cellBack;

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
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [self setCell1:nil];
    [self setCell2:nil];
    [self setCell3:nil];
    [self setCellFinal:nil];
    [self setCellAll:nil];
    [self setCellFront:nil];
    [self setCellSide:nil];
    [self setCellBack:nil];
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
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (section == 0) {
        return 4;
    }
    else {
        return 4;
    }
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Set navigation bar title
    ((PhotoNavController *)self.parentViewController).phase = segue.identifier;
    PhotoScrollerViewController *psvc = (PhotoScrollerViewController *)segue.destinationViewController;
    PresentPhotosViewController *ppvc = (PresentPhotosViewController *)segue.destinationViewController;
    psvc.navigationItem.title = segue.identifier;
    ppvc.navigationItem.title = segue.identifier;
    
    // View Photos
    PhotoNavController *photoNC = [[PhotoNavController alloc] init]; 
    
    // ALL
    if ([segue.identifier isEqualToString:@"All"]) {
        ppvc.pageImages = [NSArray arrayWithObjects:
                           [photoNC loadImage:@"Start Phase 1 Front"],
                           [photoNC loadImage:@"Start Phase 1 Side"],
                           [photoNC loadImage:@"Start Phase 1 Back"],
                           [photoNC loadImage:@"Start Phase 2 Front"],
                           [photoNC loadImage:@"Start Phase 2 Side"],
                           [photoNC loadImage:@"Start Phase 2 Back"],
                           [photoNC loadImage:@"Start Phase 3 Front"],
                           [photoNC loadImage:@"Start Phase 3 Side"],
                           [photoNC loadImage:@"Start Phase 3 Back"],
                           [photoNC loadImage:@"Final Front"],
                           [photoNC loadImage:@"Final Side"],
                           [photoNC loadImage:@"Final Back"],
                           nil];
    }
    // FRONT
    else if ([segue.identifier isEqualToString:@"Front"]) {
        ppvc.pageImages = [NSArray arrayWithObjects:
                           [photoNC loadImage:@"Start Phase 1 Front"],
                           [photoNC loadImage:@"Start Phase 2 Front"],
                           [photoNC loadImage:@"Start Phase 3 Front"],
                           [photoNC loadImage:@"Final Front"],
                           nil];
    }
    // SIDE
    else if ([segue.identifier isEqualToString:@"Side"]) {
        ppvc.pageImages = [NSArray arrayWithObjects:
                           [photoNC loadImage:@"Start Phase 1 Side"],
                           [photoNC loadImage:@"Start Phase 2 Side"],
                           [photoNC loadImage:@"Start Phase 3 Side"],
                           [photoNC loadImage:@"Final Side"],
                           nil];
    }
    // BACK
    else if ([segue.identifier isEqualToString:@"Back"]) {
        ppvc.pageImages = [NSArray arrayWithObjects:
                           [photoNC loadImage:@"Start Phase 1 Back"],
                           [photoNC loadImage:@"Start Phase 2 Back"],
                           [photoNC loadImage:@"Start Phase 3 Back"],
                           [photoNC loadImage:@"Final Back"],
                           nil];
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
    cellFinal.backgroundColor = cellbackgroundColor;
    cellAll.backgroundColor = cellbackgroundColor;
    cellFront.backgroundColor = cellbackgroundColor;
    cellSide.backgroundColor = cellbackgroundColor;
    cellBack.backgroundColor = cellbackgroundColor;
    
    // Label backgrounds
    cell1.textLabel.backgroundColor = [UIColor clearColor];
    cell1.detailTextLabel.backgroundColor = [UIColor clearColor];
    
    cell2.textLabel.backgroundColor = [UIColor clearColor];
    cell2.detailTextLabel.backgroundColor = [UIColor clearColor];
    
    cell3.textLabel.backgroundColor = [UIColor clearColor];
    cell3.detailTextLabel.backgroundColor = [UIColor clearColor];
    
    cellFinal.textLabel.backgroundColor = [UIColor clearColor];
    cellFinal.detailTextLabel.backgroundColor = [UIColor clearColor];
    
    cellAll.textLabel.backgroundColor = [UIColor clearColor];
    cellAll.detailTextLabel.backgroundColor = [UIColor clearColor];
    
    cellFront.textLabel.backgroundColor = [UIColor clearColor];
    cellFront.detailTextLabel.backgroundColor = [UIColor clearColor];
    
    cellSide.textLabel.backgroundColor = [UIColor clearColor];
    cellSide.detailTextLabel.backgroundColor = [UIColor clearColor];
    
    cellBack.textLabel.backgroundColor = [UIColor clearColor];
    cellBack.detailTextLabel.backgroundColor = [UIColor clearColor];
    
    // Accessory view icon
    UIImage* accessory = [UIImage imageNamed:@"icon-arrow-blue.png"];
    UIImageView* accessoryView1 = [[UIImageView alloc] initWithImage:accessory];
    UIImageView* accessoryView2 = [[UIImageView alloc] initWithImage:accessory];
    UIImageView* accessoryView3 = [[UIImageView alloc] initWithImage:accessory];
    UIImageView* accessoryViewFinal = [[UIImageView alloc] initWithImage:accessory];
    UIImageView* accessoryViewAll = [[UIImageView alloc] initWithImage:accessory];
    UIImageView* accessoryViewFront = [[UIImageView alloc] initWithImage:accessory];
    UIImageView* accessoryViewSide = [[UIImageView alloc] initWithImage:accessory];
    UIImageView* accessoryViewBack = [[UIImageView alloc] initWithImage:accessory];
    
    cell1.accessoryView = accessoryView1;
    cell2.accessoryView = accessoryView2;
    cell3.accessoryView = accessoryView3;
    cellFinal.accessoryView = accessoryViewFinal;
    cellAll.accessoryView = accessoryViewAll;
    cellFront.accessoryView = accessoryViewFront;
    cellSide.accessoryView = accessoryViewSide;
    cellBack.accessoryView = accessoryViewBack;
}
@end
