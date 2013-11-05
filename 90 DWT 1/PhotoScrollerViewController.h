//
//  PhotoScrollerViewController.h
//  i90X
//
//  Created by Jared Grant on 7/14/12.
//  Copyright (c) 2012 g-rantsoftware.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoScrollerDetailViewController.h"
#import "PhotoNavController.h"
#import <CoreImage/CoreImage.h>
#import <MediaPlayer/MediaPlayer.h>
#import <Twitter/Twitter.h>
#import <MessageUI/MessageUI.h>

@interface PhotoScrollerViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate, MPMediaPickerControllerDelegate, UIScrollViewDelegate, MFMailComposeViewControllerDelegate>

@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) IBOutlet UIPageControl *pageControl;

- (IBAction)emailPhotos:(id)sender;
- (IBAction)sendTwitter:(id)sender;
@end
