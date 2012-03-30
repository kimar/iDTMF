//
//  DTMFViewController.h
//  iDTMF
//
//  Created by Marcus Kida on 14.04.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/ABPeoplePickerNavigationController.h>

#import "iDTMFAppDelegate.h"

@interface DTMFViewController : UIViewController <ABPeoplePickerNavigationControllerDelegate> {
    iDTMFAppDelegate *appDelegate;
    
    IBOutlet UILabel *numbersLabel;
}

- (void)dtmfKeyToNumbersLabel:(NSString *)dtmfNumber;

#pragma mark - Button Actions
- (IBAction)dtmfKeySelected:(id)sender;
- (IBAction)dtmfKeyReleased;

- (IBAction)callSelected;
- (IBAction)backspaceSelected;

- (IBAction)openPeoplePicker;

#pragma mark - Addressbook


@end
