//
//  DTMFViewController.m
//  iDTMF
//
//  Created by Marcus Kida on 14.04.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
#import "Constants.h"

#import "DTMFViewController.h"


@implementation DTMFViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    appDelegate = (iDTMFAppDelegate *)[[UIApplication sharedApplication] delegate];
    [numbersLabel setFont:[UIFont fontWithName:@"DBLCDTempBlack" size:48.0]];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dtmfKeyToNumbersLabel:(NSString *)dtmfNumber
{
    [numbersLabel setText:[NSString stringWithFormat:@"%@%@", [numbersLabel text], dtmfNumber]];
}

#pragma mark - Button Actions
- (IBAction)dtmfKeySelected:(id)sender
{
    if (!appDelegate.isTonePlaying)
    {
        int senderTag = [sender tag];
        
        if (kDebug)
        {
            NSLog(@"DEBUG: dtmfKeySelected Tag: %d", senderTag);
        }
        
        switch (senderTag) {
            case 0:
                [appDelegate startDtmfTonePlayWithFreq1:697 andFre2q:1209];
                [self dtmfKeyToNumbersLabel:@"1"];
                break;
            case 1:
                [appDelegate startDtmfTonePlayWithFreq1:697 andFre2q:1336];
                [self dtmfKeyToNumbersLabel:@"2"];
                break;
            case 2:
                [appDelegate startDtmfTonePlayWithFreq1:697 andFre2q:1477];
                [self dtmfKeyToNumbersLabel:@"3"];
                break;
            case 3:
                [appDelegate startDtmfTonePlayWithFreq1:770 andFre2q:1209];
                [self dtmfKeyToNumbersLabel:@"4"];
                break;
            case 4:
                [appDelegate startDtmfTonePlayWithFreq1:770 andFre2q:1336];
                [self dtmfKeyToNumbersLabel:@"5"];
                break;
            case 5:
                [appDelegate startDtmfTonePlayWithFreq1:770 andFre2q:1477];
                [self dtmfKeyToNumbersLabel:@"6"];
                break;
            case 6:
                [appDelegate startDtmfTonePlayWithFreq1:852 andFre2q:1209];
                [self dtmfKeyToNumbersLabel:@"7"];
                break;
            case 7:
                [appDelegate startDtmfTonePlayWithFreq1:852 andFre2q:1336];
                [self dtmfKeyToNumbersLabel:@"8"];
                break;
            case 8:
                [appDelegate startDtmfTonePlayWithFreq1:852 andFre2q:1477];
                [self dtmfKeyToNumbersLabel:@"9"];
                break;
            case 9:
                [appDelegate startDtmfTonePlayWithFreq1:941 andFre2q:1209];
                [self dtmfKeyToNumbersLabel:@"*"];
                break;
            case 10:
                [appDelegate startDtmfTonePlayWithFreq1:941 andFre2q:1336];
                [self dtmfKeyToNumbersLabel:@"0"];
                break;
            case 11:
                [appDelegate startDtmfTonePlayWithFreq1:941 andFre2q:1477];
                [self dtmfKeyToNumbersLabel:@"#"];
                break;
            default:
                break;
        }
    }
    else
    {
        if (kDebug)
        {
            NSLog(@"DEBUG: we're already playing!");
        }
    }
}

- (IBAction)dtmfKeyReleased
{
    [appDelegate stopDtmfTonePlay];
}

- (IBAction)callSelected
{
    if (!appDelegate.isTonePlaying)
    {
        appDelegate.dtmfToneKeys = [numbersLabel text];
        [appDelegate startDtmfTonePlayWithCall];
        appDelegate.isTonePlaying = YES;
    }
}

- (IBAction)backspaceSelected
{
    if ( [[numbersLabel text] length] > 0 ) numbersLabel.text = [[numbersLabel text] substringToIndex:[[numbersLabel text] length] - 1];
}

- (IBAction)openPeoplePicker
{
    if (kDebug)
    {
        NSLog(@"DEBUG: openPeoplePicker");
    }
    
	ABPeoplePickerNavigationController *peoplePicker = [[ABPeoplePickerNavigationController alloc] init];
	ABAddressBookRef addressBook = ABAddressBookCreate();
	
 	peoplePicker.addressBook = addressBook;
	
	NSNumber* numberProp = [NSNumber numberWithInt:kABPersonPhoneProperty];
	peoplePicker.displayedProperties = [NSArray arrayWithObject:numberProp];
	
	[peoplePicker setPeoplePickerDelegate:self];
	peoplePicker.navigationBar.barStyle = UIBarStyleDefault;
	
	[self presentModalViewController:peoplePicker animated:YES];
}

#pragma mark - Addressbook
#pragma mark -
#pragma mark Addressbook
- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker
{
	[self dismissModalViewControllerAnimated:YES];
}

- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier {
	[self dismissModalViewControllerAnimated:YES];
	[[[self parentViewController] view] setNeedsDisplay];
	if (person) {
		ABMultiValueRef numbers = ABRecordCopyValue(person, property);
		//CFStringRef number = ABMultiValueCopyValueAtIndex(numbers, identifier); //Crashing on some numbers :( ...
		NSString *number = (NSString *)ABMultiValueCopyValueAtIndex(numbers, ABMultiValueGetIndexForIdentifier(numbers, identifier));
		if (number) {
			[numbersLabel setText:[appDelegate normalizePhoneNumberFromString:(NSString *)number]];
		}
	}
	return NO;	
}

- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person {
	return YES;
}

@end
