//
//  iDTMFAppDelegate.h
//  iDTMF
//
//  Created by Marcus Kida on 14.04.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AVBufferPlayer.h"

@interface iDTMFAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate> {
    NSUserDefaults *defaults;
    AVBufferPlayer* player;
    
    BOOL isTonePlaying;
    NSString *dtmfToneKeys;
    
    NSString *lastZveiString;
    NSString *zveiToneKeys;
    
    int samplerate;
    float gainVal;
    float dtmfTonePauseInterval;
    float zveiTonePauseInterval;
    float zveiRepeatPauseInterval;
    
}
@property (nonatomic, retain) NSUserDefaults *defaults;;

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;

@property (nonatomic, assign) BOOL isTonePlaying;
@property (nonatomic, retain) IBOutlet NSString *dtmfToneKeys;
@property (nonatomic, retain) IBOutlet NSString *zveiToneKeys;

@property (nonatomic, assign) int samplerate;
@property (nonatomic, assign) float gainVal;
@property (nonatomic, assign) float dtmfTonePauseInterval;
@property (nonatomic, assign) float zveiTonePauseInterval;
@property (nonatomic, assign) float zveiRepeatPauseInterval;


#pragma mark - Specials
- (void)startDtmfTonePlayWithCall;
- (void)startDtmfTonePlayWithCallThread;

- (void)startZveiTonePlayWithCall;
- (void)startZveiTonePlayWithCallThread;

- (void)startZveiTonePlayWithCall2;
- (void)startZveiTonePlayWithCallThread2;

#pragma mark - DTMF Player
- (void)startDtmfTonePlayWithFreq1:(int)freq1 andFre2q:(int)freq2;
- (void)stopDtmfTonePlay;

#pragma mark - ZVEI Player
- (void)startZveiTonePlayWithFreq:(int)freq;
- (void)stopZveiTonePlay;

#pragma mark - Helpers
- (NSString *)normalizePhoneNumberFromString:(NSString *)numberString;

@end
