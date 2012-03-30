//
//  iDTMFAppDelegate.m
//  iDTMF
//
//  Created by Marcus Kida on 14.04.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
#import "Constants.h"

#import "iDTMFAppDelegate.h"

@implementation iDTMFAppDelegate

@synthesize defaults;

@synthesize window=_window;

@synthesize tabBarController=_tabBarController;

@synthesize isTonePlaying, dtmfToneKeys, zveiToneKeys;

@synthesize samplerate, gainVal, dtmfTonePauseInterval, zveiTonePauseInterval, zveiRepeatPauseInterval;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    // Add the tab bar controller's current view as a subview of the window
    defaults = [NSUserDefaults standardUserDefaults];
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
    if ([defaults integerForKey:kDefaultsSamplerate] == 0)
    {
        samplerate = 44100;
    }
    else
    {
        samplerate = [defaults integerForKey:kDefaultsSamplerate];
    }
    if (kDebug)
    {
        NSLog(@"DEBUG: samplerate: %d", samplerate);
    }
    
    
    if ([defaults floatForKey:kDefaultsGain] == 0.0f) 
    {
        gainVal = 0.4f;
    }
    else
    {
        gainVal = [defaults floatForKey:kDefaultsGain];
    }
    if (kDebug)
    {
        NSLog(@"DEBUG: gainVal: %f", gainVal);
    }
    
    if ([defaults floatForKey:kDefaultsDtmfTonePause] == 0.0f) 
    {
        dtmfTonePauseInterval = 0.07f;
    }
    else
    {
        dtmfTonePauseInterval = [defaults floatForKey:kDefaultsDtmfTonePause];
    }
    if (kDebug)
    {
        NSLog(@"DEBUG: dtmfTonePauseInterval: %f", dtmfTonePauseInterval);
    }
    
    if ([defaults floatForKey:kDefaultsZveiTonePause] == 0.0f) 
    {
        zveiTonePauseInterval = 0.04f;
    }
    else
    {
        zveiTonePauseInterval = [defaults floatForKey:kDefaultsZveiTonePause];
    }
    if (kDebug)
    {
        NSLog(@"DEBUG: zveiTonePauseInterval: %f", zveiTonePauseInterval);
    }
    
    if ([defaults floatForKey:kDefaultsZveiRepeatPause] == 0.0f) 
    {
        zveiRepeatPauseInterval = 0.6f;
    }
    else
    {
        zveiRepeatPauseInterval = [defaults floatForKey:kDefaultsZveiRepeatPause];
    }
    if (kDebug)
    {
        NSLog(@"DEBUG: zveiRepeatPauseInterval: %f", zveiRepeatPauseInterval);
    }
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

- (void)dealloc
{
    [_window release];
    [_tabBarController release];
    [super dealloc];
}

#pragma - Specials
- (void)startDtmfTonePlayWithCall
{
    if (kDebug) 
    {
        NSLog(@"DEBUG: startDtmfTonePlayWithCall");
    }
    
    [NSThread detachNewThreadSelector:@selector(startDtmfTonePlayWithCallThread) toTarget:self withObject:nil];
}

- (void)startDtmfTonePlayWithCallThread
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    for (int i=0; i < [dtmfToneKeys length]; i++) {
        
        if (isTonePlaying) {
            [player stop];
            isTonePlaying = NO;
        }
        
        NSString *keyChar  = [NSString stringWithFormat:@"%c", [dtmfToneKeys characterAtIndex:i]];
        
        if (kDebug)
        {
            NSLog(@"DEBUG: now playing key char: %@", keyChar);
        }
        
        if ([keyChar isEqualToString:@"1"]) 
        {
            [self startDtmfTonePlayWithFreq1:697 andFre2q:1209];
        } 
        else if ([keyChar isEqualToString:@"2"])
        {
            [self startDtmfTonePlayWithFreq1:697 andFre2q:1336];
        }
        else if ([keyChar isEqualToString:@"3"])
        {
            [self startDtmfTonePlayWithFreq1:697 andFre2q:1477];
        }
        else if ([keyChar isEqualToString:@"4"])
        {
            [self startDtmfTonePlayWithFreq1:770 andFre2q:1209];
        }
        else if ([keyChar isEqualToString:@"5"])
        {
            [self startDtmfTonePlayWithFreq1:770 andFre2q:1336];
        }
        else if ([keyChar isEqualToString:@"6"])
        {
            [self startDtmfTonePlayWithFreq1:770 andFre2q:1477];
        }
        else if ([keyChar isEqualToString:@"7"])
        {
            [self startDtmfTonePlayWithFreq1:852 andFre2q:1209];
        }
        else if ([keyChar isEqualToString:@"8"])
        {
            [self startDtmfTonePlayWithFreq1:852 andFre2q:1336];
        }
        else if ([keyChar isEqualToString:@"9"])
        {
            [self startDtmfTonePlayWithFreq1:852 andFre2q:1477];
        }
        else if ([keyChar isEqualToString:@"*"])
        {
            [self startDtmfTonePlayWithFreq1:941 andFre2q:1209];
        }
        else if ([keyChar isEqualToString:@"0"])
        {
            [self startDtmfTonePlayWithFreq1:941 andFre2q:1336];
        }
        else if ([keyChar isEqualToString:@"#"])
        {
            [self startDtmfTonePlayWithFreq1:941 andFre2q:1477];
        }
        
        isTonePlaying = YES;
        
        [NSThread sleepForTimeInterval:dtmfTonePauseInterval];//.07];
    }
    
    if (isTonePlaying) {
        [player stop];
        isTonePlaying = NO;
    }
    
    [pool release];
}

- (void)startZveiTonePlayWithCall
{
    [NSThread detachNewThreadSelector:@selector(startZveiTonePlayWithCallThread) toTarget:self withObject:nil];
}

- (void)startZveiTonePlayWithCallThread
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    lastZveiString = @"";
    
    for (int i=0; i < [zveiToneKeys length]; i++) {
        
        if (isTonePlaying) {
            [player stop];
            isTonePlaying = NO;
        }
        
        NSString *keyChar  = [NSString stringWithFormat:@"%c", [zveiToneKeys characterAtIndex:i]];
        
        if (kDebug)
        {
            NSLog(@"DEBUG: now playing key char: %@", keyChar);
        }
        
        if ([lastZveiString isEqualToString:keyChar]) 
        {
            [self startZveiTonePlayWithFreq:2600];
        }
        else if ([keyChar isEqualToString:@"1"]) 
        {
            [self startZveiTonePlayWithFreq:1060];
        } 
        else if ([keyChar isEqualToString:@"2"])
        {
            [self startZveiTonePlayWithFreq:1160];
        }
        else if ([keyChar isEqualToString:@"3"])
        {
            [self startZveiTonePlayWithFreq:1270];
        }
        else if ([keyChar isEqualToString:@"4"])
        {
            [self startZveiTonePlayWithFreq:1400];
        }
        else if ([keyChar isEqualToString:@"5"])
        {
            [self startZveiTonePlayWithFreq:1530];
        }
        else if ([keyChar isEqualToString:@"6"])
        {
            [self startZveiTonePlayWithFreq:1670];
        }
        else if ([keyChar isEqualToString:@"7"])
        {
            [self startZveiTonePlayWithFreq:1830];
        }
        else if ([keyChar isEqualToString:@"8"])
        {
            [self startZveiTonePlayWithFreq:2000];
        }
        else if ([keyChar isEqualToString:@"9"])
        {
            [self startZveiTonePlayWithFreq:2200];
        }
        else if ([keyChar isEqualToString:@"0"])
        {
            [self startZveiTonePlayWithFreq:2400];
        }
        
        lastZveiString = keyChar;
        
        isTonePlaying = YES;
        
        [NSThread sleepForTimeInterval:zveiTonePauseInterval];
    }
    
    if (isTonePlaying) {
        [player stop];
        isTonePlaying = NO;
    }
    
    [pool release];
}

- (void)startZveiTonePlayWithCall2
{
    [NSThread detachNewThreadSelector:@selector(startZveiTonePlayWithCallThread2) toTarget:self withObject:nil];
}

- (void)startZveiTonePlayWithCallThread2
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    lastZveiString = @"";
    
    for (int l=0; l<2; l++) 
    {
        for (int i=0; i < [zveiToneKeys length]; i++) 
        {
            
            if (isTonePlaying) {
                [player stop];
                isTonePlaying = NO;
            }
            
            NSString *keyChar  = [NSString stringWithFormat:@"%c", [zveiToneKeys characterAtIndex:i]];
            
            if (kDebug)
            {
                NSLog(@"DEBUG: now playing key char: %@", keyChar);
            }
            
            if ([lastZveiString isEqualToString:keyChar]) 
            {
                [self startZveiTonePlayWithFreq:2600];
            }
            else if ([keyChar isEqualToString:@"1"]) 
            {
                [self startZveiTonePlayWithFreq:1060];
            } 
            else if ([keyChar isEqualToString:@"2"])
            {
                [self startZveiTonePlayWithFreq:1160];
            }
            else if ([keyChar isEqualToString:@"3"])
            {
                [self startZveiTonePlayWithFreq:1270];
            }
            else if ([keyChar isEqualToString:@"4"])
            {
                [self startZveiTonePlayWithFreq:1400];
            }
            else if ([keyChar isEqualToString:@"5"])
            {
                [self startZveiTonePlayWithFreq:1530];
            }
            else if ([keyChar isEqualToString:@"6"])
            {
                [self startZveiTonePlayWithFreq:1670];
            }
            else if ([keyChar isEqualToString:@"7"])
            {
                [self startZveiTonePlayWithFreq:1830];
            }
            else if ([keyChar isEqualToString:@"8"])
            {
                [self startZveiTonePlayWithFreq:2000];
            }
            else if ([keyChar isEqualToString:@"9"])
            {
                [self startZveiTonePlayWithFreq:2200];
            }
            else if ([keyChar isEqualToString:@"0"])
            {
                [self startZveiTonePlayWithFreq:2400];
            }
            
            lastZveiString = keyChar;
            
            isTonePlaying = YES;
            
            [NSThread sleepForTimeInterval:zveiTonePauseInterval];
        }
        
        if (isTonePlaying) {
            [player stop];
            isTonePlaying = NO;
        }
        
        [NSThread sleepForTimeInterval:zveiRepeatPauseInterval];//.6];
    }
    
    [pool release];
}

#pragma mark - DTMF Player
- (void)startDtmfTonePlayWithFreq1:(int)freq1 andFre2q:(int)freq2
{
    //const int freq1 = 697;
    //const int freq2 = 1209;
    const int seconds = 1;
    const int sampleRate = samplerate;//44100;
    const float gain = gainVal;//0.5f;
    
    int frames = seconds * sampleRate;
    float* buffer = (float*)malloc(frames*sizeof(float));
    
    for (int i = 0; i < frames; i++)
    {
        // DTMF signal
        buffer[i] = gain * (sinf(i*2*M_PI*freq1/sampleRate) + sinf(i*2*M_PI*freq2/sampleRate));
        
        // Simple 440Hz sine wave
        //buffer[i] = gain * sinf(i*2*M_PI*440/sampleRate)
    }
    
    player = [[AVBufferPlayer alloc] initWithBuffer:buffer frames:frames];
    free(buffer);
    
    if (isTonePlaying)
    {
        [player stop];
        isTonePlaying = NO;
    }
    
    [player play];
    isTonePlaying = YES;
}

- (void)stopDtmfTonePlay
{
    [player stop];
    isTonePlaying = NO;
}

#pragma mark - ZVEI Player
- (void)startZveiTonePlayWithFreq:(int)freq
{
    //const int freq1 = 697;
    //const int freq2 = 1209;
    const int seconds = 1;
    const int sampleRate = samplerate;//44100;
    const float gain = gainVal;//0.5f;
    
    int frames = seconds * sampleRate;
    float* buffer = (float*)malloc(frames*sizeof(float));
    
    for (int i = 0; i < frames; i++)
    {
        // DTMF signal
        buffer[i] = gain * (sinf(i*2*M_PI*freq/sampleRate) + sinf(i*2*M_PI*freq/sampleRate));
        
        // Simple 440Hz sine wave
        //buffer[i] = gain * sinf(i*2*M_PI*440/sampleRate)
    }
    
    player = [[AVBufferPlayer alloc] initWithBuffer:buffer frames:frames];
    free(buffer);
    
    if (isTonePlaying)
    {
        [player stop];
        isTonePlaying = NO;
    }
    
    [player play];
    isTonePlaying = YES;    
}

- (void)stopZveiTonePlay
{
    [player stop];
    isTonePlaying = NO;
}

#pragma mark - Helpers
- (NSString *)normalizePhoneNumberFromString:(NSString *)numberString 
{
	numberString = [numberString stringByReplacingOccurrencesOfString:@"+" withString:@"00"];
	numberString = [numberString stringByReplacingOccurrencesOfString:@"(" withString:@""];
	numberString = [numberString stringByReplacingOccurrencesOfString:@")" withString:@""];
	numberString = [numberString stringByReplacingOccurrencesOfString:@" " withString:@""];
	numberString = [numberString stringByReplacingOccurrencesOfString:@"/" withString:@""];
	numberString = [numberString stringByReplacingOccurrencesOfString:@"\\" withString:@""];
	numberString = [numberString stringByReplacingOccurrencesOfString:@"#" withString:@""];
	numberString = [numberString stringByReplacingOccurrencesOfString:@"-" withString:@""];
	return numberString;
}

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
}
*/

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{
}
*/

@end
