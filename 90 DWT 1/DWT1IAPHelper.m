//
//  HMIAPHelper.m
//  90 DWT 1
//
//  Created by Grant, Jared on 5/10/13.
//  Copyright (c) 2013 Grant, Jared. All rights reserved.
//

#import "DWT1IAPHelper.h"

@implementation DWT1IAPHelper

+ (DWT1IAPHelper *)sharedInstance {
    
    static dispatch_once_t once;
    static DWT1IAPHelper * sharedInstance;
    
    dispatch_once(&once, ^{
        NSSet * productIdentifiers = [NSSet setWithObjects: @"com.grantsoftware.90DWT1.slidergraph", @"com.grantsoftware.90DWT1.removeads1", nil];
        sharedInstance = [[self alloc] initWithProductIdentifiers:productIdentifiers];
    });
    
    return sharedInstance;
}

@end
