//
//  ZVEIViewController.h
//  iDTMF
//
//  Created by Marcus Kida on 15.04.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
#import <UIKit/UIKit.h>

#import "iDTMFAppDelegate.h"

@interface ZVEIViewController : UIViewController {
    iDTMFAppDelegate *appDelegate;
    IBOutlet UILabel *numbersLabel;
    NSInteger cursorPos;
    
}

#pragma mark - Button Actions
- (IBAction)numberPress:(id)sender;
- (IBAction)backPress:(id)sender;

- (IBAction)callSelected:(id)sender;

- (IBAction)rCallSelected:(id)sender;
- (IBAction)rCallReleased:(id)sender;


@end
