//
//  SettingsViewController.h
//  iDTMF
//
//  Created by Marcus Kida on 15.04.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "iDTMFAppDelegate.h"

@interface SettingsViewController : UIViewController {
    iDTMFAppDelegate *appDelegate;
    
    IBOutlet UILabel *samplerateLabel;
    IBOutlet UILabel *gainLabel;
    IBOutlet UILabel *dtmfTonePauseLabel;
    IBOutlet UILabel *zveiTonePauseLabel;
    IBOutlet UILabel *zveiRepeatPauseLabel;
    
    IBOutlet UISlider *samplerateSlider;
    IBOutlet UISlider *gainSlider;
    IBOutlet UISlider *dtmfTonePauseSlider;
    IBOutlet UISlider *zveiTonePauseSlider;
    IBOutlet UISlider *zveiRepeatPauseSlider;

}

#pragma mark - Button Actions
- (IBAction)changeSetting:(id)sender;
- (IBAction)saveSettings:(id)sender;
- (IBAction)resetToDefaults:(id)sender;

@end
