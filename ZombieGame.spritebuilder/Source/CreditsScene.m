//
//  CreditsScene.m
//  Zombie Mob
//
//  Created by Lynne Okada on 1/8/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "CreditsScene.h"

@implementation CreditsScene

- (void) exit
{
    CCScene *exit = [CCBReader loadAsScene:@"MenuScene"];
    CCTransition *transition = [CCTransition transitionFadeWithDuration:0.3f];
    [[CCDirector sharedDirector] replaceScene:exit withTransition:transition];
}

@end
