//
//  MenuScene.m
//  Zombie Mob
//
//  Created by Lynne Okada on 1/6/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "MenuScene.h"

@implementation MenuScene

- (void) start
{
    CCScene *start = [CCBReader loadAsScene:@"MainScene"];
    CCTransition *transition = [CCTransition transitionFadeWithDuration:0.3f];
    [[CCDirector sharedDirector] replaceScene:start withTransition:transition];
}

- (void) tutorial
{
    CCScene *tutorial = [CCBReader loadAsScene:@"TutorialScene"];
    CCTransition *transition = [CCTransition transitionFadeWithDuration:0.3f];
    [[CCDirector sharedDirector] replaceScene:tutorial withTransition:transition];
}

- (void) credits
{
    CCScene *credits = [CCBReader loadAsScene:@"CreditsScene"];
    CCTransition *transition = [CCTransition transitionFadeWithDuration:0.3f];
    [[CCDirector sharedDirector] replaceScene:credits withTransition:transition];
}

@end
