//
//  PhotoNavController.h
//  i90X
//
//  Created by Jared Grant on 7/14/12.
//  Copyright (c) 2012 g-rantsoftware.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoNavController : UINavigationController

@property (strong, nonatomic) NSString *phase; // Current phase for pictures.

- (void)saveImage:(UIImage*)image:(NSString*)imageName;
- (UIImage*)loadImage:(NSString*)imageName;
- (void)removeImage:(NSString*)fileName;
- (NSData*)emailImage:(NSString*)imageName;

@end
