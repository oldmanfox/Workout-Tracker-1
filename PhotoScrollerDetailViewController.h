//
//  PhotoScrollerDetailViewController.h
//  90 DWT 1
//
//  Created by Jared Grant on 7/14/12.
//  Copyright (c) 2012 g-rantsoftware.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoNavController.h"
#import "UIImage+Resizing.h"
#import <CoreImage/CoreImage.h>
#import <MediaPlayer/MediaPlayer.h>

@interface PhotoScrollerDetailViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate, MPMediaPickerControllerDelegate, UIPopoverControllerDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *displayImageView;
@property (strong, nonatomic) NSString *picAngle;  // Front, Side, or Back
@property (strong, nonatomic) NSString *picTitle;  // Created from month and picAngle
@property (strong, nonatomic) UIPopoverController *popoverController;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

- (IBAction)frontImage:(id)sender;
- (IBAction)sideImage:(id)sender;
- (IBAction)backImage:(id)sender;
@end
