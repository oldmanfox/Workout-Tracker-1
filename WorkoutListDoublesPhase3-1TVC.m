//
//  WorkoutListDoublesPhase3-1TVC.m
//  90 DWT 1
//
//  Created by Jared Grant on 7/14/12.
//  Copyright (c) 2012 g-rantsoftware.com. All rights reserved.
//

#import "WorkoutListDoublesPhase3-1TVC.h"
#import "DWT1IAPHelper.h"

@interface WorkoutListDoublesPhase3_1TVC ()

@end

@implementation WorkoutListDoublesPhase3_1TVC

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
        //self.canDisplayBannerAds = NO;
        
    } else {
        
        // Show the Banner Ad
        //self.canDisplayBannerAds = YES;
        
        self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 0)];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            
            // iPhone
            self.adView = [[MPAdView alloc] initWithAdUnitId:@"4bed96fcb70a4371b972bf19d149e433"
                                                        size:MOPUB_BANNER_SIZE];
            self.bannerSize = MOPUB_BANNER_SIZE;
            
        } else {
            
            // iPad
            self.adView = [[MPAdView alloc] initWithAdUnitId:@"7c80f30698634a22b77778b084e3087e"
                                                        size:MOPUB_LEADERBOARD_SIZE];
            self.bannerSize = MOPUB_LEADERBOARD_SIZE;
            
        }
        
        self.adView.delegate = self;
        self.adView.frame = CGRectMake((self.view.bounds.size.width - self.bannerSize.width) / 2,
                                       self.bannerSize.height - self.bannerSize.height,
                                       self.bannerSize.width, self.bannerSize.height);
        
        [self.headerView addSubview:self.adView];
        
        [self.adView loadAd];
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

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:YES];
    
    // Show or Hide Ads
    if ([[DWT1IAPHelper sharedInstance] productPurchased:@"com.grantsoftware.90DWT1.removeads1"]) {
        
        // Don't show ads.
        self.tableView.tableHeaderView = nil;
        self.adView.delegate = nil;
        self.adView = nil;
        
    } else {
        
        // Show ads
        self.adView.hidden = YES;
    }
}

- (void)viewDidAppear:(BOOL)animated {
    
    // Show or Hide Ads
    if ([[DWT1IAPHelper sharedInstance] productPurchased:@"com.grantsoftware.90DWT1.removeads1"]) {
        
        // Don't show ads.
        self.tableView.tableHeaderView = nil;
        self.adView.delegate = nil;
        self.adView = nil;
        
    } else {
        
        // Show ads
        self.adView.frame = CGRectMake((self.view.bounds.size.width - self.bannerSize.width) / 2,
                                       self.bannerSize.height - self.bannerSize.height,
                                       self.bannerSize.width, self.bannerSize.height);
        self.adView.hidden = NO;
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
                    @"Chest + Back & Ab Workout",
                    @"Full on Cardio",
                    @"Plyometrics",
                    @"Shoulders + Arms & Ab Workout",
                    @"Full on Cardio",
                    @"Yoga",
                    @"Full on Cardio",
                    @"Legs + Back & Ab Workout",
                    @"Judo Chop",
                    @"Stretch or Rest"];
    
    // Week 9
    if ([week isEqualToString:@"Week 9"]) {
        
        if (indexPath.section == 0) {
            
            if (indexPath.row == 0) {
                
                // Full on Cardio 10
                ((DataNavController *)self.parentViewController).index = @10;
                ((DataNavController *)self.parentViewController).workout = workoutArray[0];
            }
            
            else if (indexPath.row == 1) {
            
            // Chest + Back 4
            ((DataNavController *)self.parentViewController).index = @4;
                ((DataNavController *)self.parentViewController).workout = workoutArray[1];
            }
        }
        
        else if (indexPath.section == 1) {
            
            if (indexPath.row == 0) {
                
                // Full on Cardio 11
                ((DataNavController *)self.parentViewController).index = @11;
                ((DataNavController *)self.parentViewController).workout = workoutArray[2];
            }
            
            else if (indexPath.row == 1) {
                
                // Plyometrics 7
                ((DataNavController *)self.parentViewController).index = @7;
                ((DataNavController *)self.parentViewController).workout = workoutArray[3];
            }
        }

        else if (indexPath.section == 2) {
            
            if (indexPath.row == 0) {
                
                // Shoulders + Arms 4
                ((DataNavController *)self.parentViewController).index = @4;
                ((DataNavController *)self.parentViewController).workout = workoutArray[4];
            }
        }

        else if (indexPath.section == 3) {
            
            if (indexPath.row == 0) {
                
                // Full on Cardio 12
                ((DataNavController *)self.parentViewController).index = @12;
                ((DataNavController *)self.parentViewController).workout = workoutArray[5];
            }
            
            else if (indexPath.row == 1) {
                
                // Yoga 11
                ((DataNavController *)self.parentViewController).index = @11;
                ((DataNavController *)self.parentViewController).workout = workoutArray[6];
            }
        }

        else if (indexPath.section == 4) {
            
            if (indexPath.row == 0) {
                
                // Full on Cardio 13
                ((DataNavController *)self.parentViewController).index = @13;
                ((DataNavController *)self.parentViewController).workout = workoutArray[7];
            }
            
            else if (indexPath.row == 1) {
                
                // Legs + Back 7
                ((DataNavController *)self.parentViewController).index = @7;
                ((DataNavController *)self.parentViewController).workout = workoutArray[8];
            }
        }

        else if (indexPath.section == 5) {
            
            if (indexPath.row == 0) {
                
                // Judo Chop 9
                ((DataNavController *)self.parentViewController).index = @9;
                ((DataNavController *)self.parentViewController).workout = workoutArray[9];
            }
        }

        else if (indexPath.section == 6) {
            
            if (indexPath.row == 0) {
                
                // Stretch 11
                ((DataNavController *)self.parentViewController).index = @11;
                ((DataNavController *)self.parentViewController).workout = workoutArray[10];
            }
        }
    }
    
    // Week 11
    else if ([week isEqualToString:@"Week 11"]) {
        
        if (indexPath.section == 0) {
            
            if (indexPath.row == 0) {
                
                // Full on Cardio 18
                ((DataNavController *)self.parentViewController).index = @18;
                ((DataNavController *)self.parentViewController).workout = workoutArray[0];
            }
            
            else if (indexPath.row == 1) {
                
                // Chest + Back 5
                ((DataNavController *)self.parentViewController).index = @5;
                ((DataNavController *)self.parentViewController).workout = workoutArray[1];
            }
        }
        
        else if (indexPath.section == 1) {
            
            if (indexPath.row == 0) {
                
                // Full on Cardio 19
                ((DataNavController *)self.parentViewController).index = @19;
                ((DataNavController *)self.parentViewController).workout = workoutArray[2];
            }
            
            else if (indexPath.row == 1) {
                
                // Plyometrics 9
                ((DataNavController *)self.parentViewController).index = @9;
                ((DataNavController *)self.parentViewController).workout = workoutArray[3];
            }
        }
        
        else if (indexPath.section == 2) {
            
            if (indexPath.row == 0) {
                
                // Shoulders + Arms 5
                ((DataNavController *)self.parentViewController).index = @5;
                ((DataNavController *)self.parentViewController).workout = workoutArray[4];
            }
        }
        
        else if (indexPath.section == 3) {
            
            if (indexPath.row == 0) {
                
                // Full on Cardio 20
                ((DataNavController *)self.parentViewController).index = @20;
                ((DataNavController *)self.parentViewController).workout = workoutArray[5];
            }
            
            else if (indexPath.row == 1) {
                
                // Yoga 13
                ((DataNavController *)self.parentViewController).index = @13;
                ((DataNavController *)self.parentViewController).workout = workoutArray[6];
            }
        }
        
        else if (indexPath.section == 4) {
            
            if (indexPath.row == 0) {
                
                // Full on Cardio 21
                ((DataNavController *)self.parentViewController).index = @21;
                ((DataNavController *)self.parentViewController).workout = workoutArray[7];
            }
            
            else if (indexPath.row == 1) {
                
                // Legs + Back 9
                ((DataNavController *)self.parentViewController).index = @9;
                ((DataNavController *)self.parentViewController).workout = workoutArray[8];
            }
        }
        
        else if (indexPath.section == 5) {
            
            if (indexPath.row == 0) {
                
                // Judo Chop 11
                ((DataNavController *)self.parentViewController).index = @11;
                ((DataNavController *)self.parentViewController).workout = workoutArray[9];
            }
        }
        
        else if (indexPath.section == 6) {
            
            if (indexPath.row == 0) {
                
                // Stretch 13
                ((DataNavController *)self.parentViewController).index = @13;
                ((DataNavController *)self.parentViewController).workout = workoutArray[10];
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

#pragma mark - <MPAdViewDelegate>
- (UIViewController *)viewControllerForPresentingModalView {
    return self;
}

- (void)adViewDidLoadAd:(MPAdView *)view
{
    CGSize size = [view adContentViewSize];
    CGFloat centeredX = (self.view.bounds.size.width - size.width) / 2;
    CGFloat bottomAlignedY = self.bannerSize.height - size.height;
    view.frame = CGRectMake(centeredX, bottomAlignedY, size.width, size.height);
    
    if (self.headerView.frame.size.height == 0) {
        
        // No ads shown yet.  Animate showing the ad.
        CGRect headerViewFrame = CGRectMake(0, 0, self.view.bounds.size.width, self.bannerSize.height);
        
        [UIView animateWithDuration:0.25 animations:^{ self.headerView.frame = headerViewFrame;
            self.tableView.tableHeaderView = self.headerView;
            self.adView.hidden = YES;}
         
                         completion:^(BOOL finished) {self.adView.hidden = NO;
                         }];
        
    } else {
        
        // Ad is already showing.
        self.tableView.tableHeaderView = self.headerView;
    }
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                duration:(NSTimeInterval)duration {
    
    self.adView.hidden = YES;
    [self.adView rotateToOrientation:toInterfaceOrientation];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    CGSize size = [self.adView adContentViewSize];
    CGFloat centeredX = (self.view.bounds.size.width - size.width) / 2;
    CGFloat bottomAlignedY = self.headerView.bounds.size.height - size.height;
    self.adView.frame = CGRectMake(centeredX, bottomAlignedY, size.width, size.height);
    
    self.adView.hidden = NO;
}
@end
