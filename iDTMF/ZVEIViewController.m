//
//  ZVEIViewController.m
//  iDTMF
//
//  Created by Marcus Kida on 15.04.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
#import "Constants.h"

#import "ZVEIViewController.h"


@implementation ZVEIViewController

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
    cursorPos = 0;
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

#pragma mark - Button Actions
- (IBAction)numberPress:(id)sender
{
    NSInteger senderTag = [sender tag];
    
    if (kDebug)
    {
        NSLog(@"DEBUG: senderTag: %d, cursorPos: %d", senderTag, cursorPos);
    }
    
    if (senderTag < 10 && cursorPos >= 0 && cursorPos < 5)
    {
        if (senderTag == 9) senderTag = -1;
        numbersLabel.text = [[numbersLabel text] stringByReplacingCharactersInRange:NSMakeRange(cursorPos,1) withString:[NSString stringWithFormat:@"%d", senderTag+1]];
        cursorPos++;
        //if (cursorPos == 5) cursorPos = 0;
        if (cursorPos > 4) cursorPos = 0;  
    }
}

- (IBAction)backPress:(id)sender
{
    if (kDebug)
    {
        NSLog(@"DEBUG: backPress, cursorPos: %d", cursorPos);
    }
    
    if (cursorPos >= 0 && cursorPos < 5)
    {
        numbersLabel.text = [[numbersLabel text] stringByReplacingCharactersInRange:NSMakeRange(cursorPos,1) withString:[NSString stringWithFormat:@"0"]];
        cursorPos--;
        if (cursorPos < 0) cursorPos = 4;
        //if (cursorPos <= 0) cursorPos = 0;
    }
}

- (IBAction)callSelected:(id)sender
{
    NSInteger senderTag = [sender tag];
    
    if (!appDelegate.isTonePlaying)
    {
        appDelegate.zveiToneKeys = [numbersLabel text];
        switch (senderTag) {
            case 0:
                [appDelegate startZveiTonePlayWithCall];
                break;
            case 1:
                [appDelegate startZveiTonePlayWithCall2];
                break;
            default:
                break;
        }
        appDelegate.isTonePlaying = YES;
    }
}

- (IBAction)rCallSelected:(id)sender
{
    NSInteger senderTag = [sender tag];
    
    [appDelegate stopZveiTonePlay];
    
    switch (senderTag)
    {
        case 0:
            [appDelegate startZveiTonePlayWithFreq:1750];
            break;
        case 1:
            [appDelegate startZveiTonePlayWithFreq:2135];
            break;
        default:
            break;
    }
    
    
}

- (IBAction)rCallReleased:(id)sender
{
    [appDelegate stopZveiTonePlay];
}

@end
