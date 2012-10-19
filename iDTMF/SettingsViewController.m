//
//  SettingsViewController.m
//  iDTMF
//
//  Created by Marcus Kida on 15.04.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
#import "Constants.h"

#import "SettingsViewController.h"


@implementation SettingsViewController

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
    
    /***
        Set our values
    ***/
    
    samplerateSlider.value = appDelegate.samplerate;
    gainSlider.value = appDelegate.gainVal;
    dtmfTonePauseSlider.value = appDelegate.dtmfTonePauseInterval;
    zveiTonePauseSlider.value = appDelegate.zveiTonePauseInterval;
    zveiRepeatPauseSlider.value = appDelegate.zveiRepeatPauseInterval;
    
    samplerateLabel.text = [NSString stringWithFormat:@"%.0f Hz", [samplerateSlider value]];
    gainLabel.text = [NSString stringWithFormat:@"%.1f", [gainSlider value]];
    dtmfTonePauseLabel.text = [NSString stringWithFormat:@"%.2f sec", [dtmfTonePauseSlider value]];
    zveiTonePauseLabel.text = [NSString stringWithFormat:@"%.2f sec", [zveiTonePauseSlider value]];
    zveiRepeatPauseLabel.text = [NSString stringWithFormat:@"%.1f sec", [zveiRepeatPauseSlider value]];

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
- (IBAction)changeSetting:(id)sender
{
    NSInteger senderTag = [sender tag];
    UISlider *slider = sender;

    if (kDebug)
    {
        NSLog(@"DEBUG: changeSetting, sender: %d, value: %f", senderTag, [slider value]);
    }
    
    switch (senderTag) {
        case 0:
            /* Samplerate */
            appDelegate.samplerate = [slider value];
            samplerateLabel.text = [NSString stringWithFormat:@"%.0f Hz", [slider value]];
            break;
        case 1:
            /* Gain */
            appDelegate.gainVal = [slider value];
            gainLabel.text = [NSString stringWithFormat:@"%.1f", [slider value]];
            break;
        case 2:
            /* DTMF tone pause */
            appDelegate.dtmfTonePauseInterval = [slider value];
            dtmfTonePauseLabel.text = [NSString stringWithFormat:@"%.2f sec", [slider value]];
            break;
        case 3:
            /* ZVEI tone pause */
            appDelegate.zveiTonePauseInterval = [slider value];
            zveiTonePauseLabel.text = [NSString stringWithFormat:@"%.2f sec", [slider value]];
            break;
        case 4:
            /* ZVEI repeat pause */
            appDelegate.zveiRepeatPauseInterval = [slider value];
            zveiRepeatPauseLabel.text = [NSString stringWithFormat:@"%.1f sec", [slider value]];
            break;
        default:
            break;
    }
}

- (IBAction)saveSettings:(id)sender
{
    [appDelegate.defaults setInteger:[[NSNumber numberWithFloat:samplerateSlider.value] intValue] forKey:kDefaultsSamplerate];
    [appDelegate.defaults setFloat:gainSlider.value forKey:kDefaultsGain];
    [appDelegate.defaults setFloat:dtmfTonePauseSlider.value forKey:kDefaultsDtmfTonePause];
    [appDelegate.defaults setFloat:zveiTonePauseSlider.value forKey:kDefaultsZveiTonePause];
    [appDelegate.defaults setFloat:zveiRepeatPauseSlider.value forKey:kDefaultsZveiRepeatPause];

}

- (IBAction)resetToDefaults:(id)sender
{
    [samplerateSlider setValue:44100 animated:YES];
    [gainSlider setValue:0.4 animated:YES];
    [dtmfTonePauseSlider setValue:0.07 animated:YES];
    [zveiTonePauseSlider setValue:0.04 animated:YES];
    [zveiRepeatPauseSlider setValue:0.6 animated:YES];
    
    samplerateLabel.text = [NSString stringWithFormat:@"%.0f Hz", [samplerateSlider value]];
    gainLabel.text = [NSString stringWithFormat:@"%.1f", [gainSlider value]];
    dtmfTonePauseLabel.text = [NSString stringWithFormat:@"%.2f sec", [dtmfTonePauseSlider value]];
    zveiTonePauseLabel.text = [NSString stringWithFormat:@"%.2f sec", [zveiTonePauseSlider value]];
    zveiRepeatPauseLabel.text = [NSString stringWithFormat:@"%.1f sec", [zveiRepeatPauseSlider value]];
    
    appDelegate.samplerate =  samplerateSlider.value;
    appDelegate.gainVal = gainSlider.value;
    appDelegate.dtmfTonePauseInterval = dtmfTonePauseSlider.value;
    appDelegate.zveiTonePauseInterval =  zveiTonePauseSlider.value;
    appDelegate.zveiRepeatPauseInterval = zveiRepeatPauseSlider.value;
}

@end
