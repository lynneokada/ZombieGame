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

@end
