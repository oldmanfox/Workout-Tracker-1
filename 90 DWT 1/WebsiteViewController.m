//
//  WebsiteViewController.m
//  i90X
//
//  Created by Jared Grant on 7/12/12.
//  Copyright (c) 2012 g-rantsoftware.com. All rights reserved.
//

#import "WebsiteViewController.h"

@interface WebsiteViewController ()

@end

@implementation WebsiteViewController
@synthesize websiteView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    NSString *websiteURLString = @"http://www.g-rantsoftware.com";
    
    NSURL *websiteURL = [[NSURL alloc] initWithString:websiteURLString];
    
    [self.websiteView loadRequest:[NSURLRequest requestWithURL:websiteURL]];
}

- (void)viewDidUnload
{
    [self setWebsiteView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
