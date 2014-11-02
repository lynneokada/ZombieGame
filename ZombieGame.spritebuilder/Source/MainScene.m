//
//  MainScene.m
//  PROJECTNAME
//
//  Created by Viktor on 10/10/13.
//  Copyright (c) 2013 Apportable. All rights reserved.
//

#import "MainScene.h"
#import "CCPhysics+ObjectiveChipmunk.h"

@implementation MainScene
{
    CGSize winSize;
    CCNode *selectionNode;
    CCNode *contentNode;
    CCNode *gameOverNode;
    CCPhysicsNode *physicsNode;
    
    CCNode *leftButton;
    CCNode *rightButton;
    CCNode *upButton;
    CCNode *downButton;
    
    CCNode *pistol;
    CCNode *shotgun;
    CCNode *flamethrower;
    CCNode *grenade;
    
    CCNode *cursor;
    CCNode *pistolCursor;
    CCNode *shotgunCursor;
    CCNode *flamethrowerCursor;
    CCNode *grenadeCursor;
    
    CCNode *southMob;
    CCNode *northMob;
    CCNode *westMob;
    CCNode *eastMob;
    CCNode *hunter;
    
    NSString *equippedWeapon;
    float cursorSpeedRight;
    float cursorSpeedLeft;
    
    int shotgunAmmo;
    int flamethrowerFuel;
    int grenadeCount;
    int kills;
    int previousHighScore;
    int multiplier;
    
    CCLabelTTF *pistolBullets;
    CCLabelTTF *shotgunBullets;
    CCLabelTTF *flamethrowerStuff;
    CCLabelTTF *grenadeNumber;
    
    CCLabelTTF *currentScore;
    CCLabelTTF *endScore;
    CCLabelTTF *highScore;
    CCNode *againButton;
    
    BOOL didHitSide;
}

- (void) didLoadFromCCB
{
    self.userInteractionEnabled = TRUE;
    didHitSide = NO;
    gameOverNode.visible = NO;
    physicsNode.collisionDelegate = self;
    //physicsNode.debugDraw = YES;
    
    northMob.physicsBody.collisionType = @"northMob";
    southMob.physicsBody.collisionType = @"southMob";
    westMob.physicsBody.collisionType = @"westMob";
    eastMob.physicsBody.collisionType = @"eastMob";
    hunter.physicsBody.collisionType = @"hunter";
    
    winSize = [CCDirector sharedDirector].viewSize;
    equippedWeapon = @"pistol";
    cursorSpeedLeft = -1.0;
    cursorSpeedRight = 1.0;
    
    kills = 0;
    shotgunAmmo = 30;
    flamethrowerFuel = 10;
    grenadeCount = 10;
    shotgunBullets.string = [NSString stringWithFormat:@"%i", (int)shotgunAmmo];
    flamethrowerStuff.string = [NSString stringWithFormat:@"%i", (int)flamethrowerFuel];
    grenadeNumber.string = [NSString stringWithFormat:@"%i", (int)grenadeCount];
}

- (void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint touchLocation = [touch locationInNode:selectionNode];
    
    //WEAPON SELECTION
    if (CGRectContainsPoint([pistol boundingBox], touchLocation))
    {
        NSLog(@"pistol equipped");
        equippedWeapon = @"pistol";
        pistolCursor.visible = YES;
        shotgunCursor.visible = NO;
        flamethrowerCursor.visible = NO;
        grenadeCursor.visible = NO;
    } else if (CGRectContainsPoint([shotgun boundingBox], touchLocation))
    {
        NSLog(@"shotgun equipped");
        equippedWeapon = @"shotgun";
        pistolCursor.visible = NO;
        shotgunCursor.visible = YES;
        flamethrowerCursor.visible = NO;
        grenadeCursor.visible = NO;
    } else if (CGRectContainsPoint([flamethrower boundingBox], touchLocation))
    {
        NSLog(@"flamethrower equipped");
        equippedWeapon = @"flamethrower";
        pistolCursor.visible = NO;
        shotgunCursor.visible = NO;
        flamethrowerCursor.visible = YES;
        grenadeCursor.visible = NO;
    } else if (CGRectContainsPoint([grenade boundingBox], touchLocation))
    {
        NSLog(@"grenade equipped");
        equippedWeapon = @"grenade";
        pistolCursor.visible = NO;
        shotgunCursor.visible = NO;
        flamethrowerCursor.visible = NO;
        grenadeCursor.visible = YES;
    }
    
    //SHOOT DIRECTION
    if (CGRectContainsPoint([leftButton boundingBox], touchLocation))
    {
        NSLog(@"left button touched");
        if ([equippedWeapon isEqual:@"pistol"])
        {
            if (cursor.position.x > winSize.width/8 && cursor.position.x < winSize.width - winSize.width/8)
            {
                westMob.position = CGPointMake(westMob.position.x - 5, westMob.position.y);
                kills += 2;
            }
        }
        else if ([equippedWeapon isEqualToString:@"shotgun"] && shotgunAmmo > 0)
        {
            if (cursor.position.x > winSize.width/4 && cursor.position.x < winSize.width - winSize.width/4)
            {
                westMob.position = CGPointMake(westMob.position.x - 10, westMob.position.y);
                kills += 5;
            }
            shotgunAmmo -= 1;
        }
        else if ([equippedWeapon isEqualToString:@"flamethrower"] && flamethrowerFuel > 0)
        {
            if (cursor.position.x > winSize.width/2.8 && cursor.position.x < winSize.width - winSize.width/2.8)
            {
                westMob.position = CGPointMake(westMob.position.x - 20, westMob.position.y);
                kills += 10;
            }
            flamethrowerFuel -= 1;
        }
        else if ([equippedWeapon isEqualToString:@"grenade"] && grenadeCount > 0)
        {
            if (cursor.position.x > winSize.width/2.3 && cursor.position.x < winSize.width - winSize.width/2.3)
            {
                westMob.position = CGPointMake(westMob.position.x - 30, westMob.position.y);
                kills += 15;
            }
            grenadeCount -= 1;
        }
    }
    else if (CGRectContainsPoint([rightButton boundingBox], touchLocation))
    {
        NSLog(@"right button touched");
        if ([equippedWeapon  isEqual:@"pistol"])
        {
            if (cursor.position.x > winSize.width/8 && cursor.position.x < winSize.width - winSize.width/8)
            {
                eastMob.position = CGPointMake(eastMob.position.x + 5, eastMob.position.y);
                kills += 2;
            }
        }
        else if ([equippedWeapon isEqualToString:@"shotgun"] && shotgunAmmo > 0)
        {
            if (cursor.position.x > winSize.width/4 && cursor.position.x < winSize.width - winSize.width/4)
            {
                eastMob.position = CGPointMake(eastMob.position.x + 10, eastMob.position.y);
                kills += 5;
            }
            shotgunAmmo -= 1;
        }
        else if ([equippedWeapon isEqualToString:@"flamethrower"] && flamethrowerFuel > 0)
        {
            if (cursor.position.x > winSize.width/2.8 && cursor.position.x < winSize.width - winSize.width/2.8)
            {
                eastMob.position = CGPointMake(eastMob.position.x + 20, eastMob.position.y);
                kills += 10;
            }
            flamethrowerFuel -= 1;
        }
        else if ([equippedWeapon isEqualToString:@"grenade"] && grenadeCount > 0)
        {
            if (cursor.position.x > winSize.width/2.3 && cursor.position.x < winSize.width - winSize.width/2.3)
            {
                eastMob.position = CGPointMake(eastMob.position.x + 30, eastMob.position.y);
                kills += 15;
            }
            grenadeCount -= 1;
        }
    }
    else if (CGRectContainsPoint([upButton boundingBox], touchLocation))
    {
        NSLog(@"up button touched");
        if ([equippedWeapon  isEqual:@"pistol"])
        {
            if (cursor.position.x > winSize.width/8 && cursor.position.x < winSize.width - winSize.width/8)
            {
                northMob.position = CGPointMake(northMob.position.x, northMob.position.y + 5);
                kills += 2;
            }
        }
        else if ([equippedWeapon isEqualToString:@"shotgun"] && shotgunAmmo >0)
        {
            if (cursor.position.x > winSize.width/4 && cursor.position.x < winSize.width - winSize.width/4)
            {
                northMob.position = CGPointMake(northMob.position.x, northMob.position.y + 10);
                kills += 5;
            }
            shotgunAmmo -= 1;
        }
        else if ([equippedWeapon isEqualToString:@"flamethrower"] && flamethrowerFuel > 0)
        {
            if (cursor.position.x > winSize.width/2.8 && cursor.position.x < winSize.width - winSize.width/2.8)
            {
                northMob.position = CGPointMake(northMob.position.x, northMob.position.y + 20);
                kills += 10;
            }
            flamethrowerFuel -= 1;
        }
        else if ([equippedWeapon isEqualToString:@"grenade"] && grenadeCount > 0)
        {
            if (cursor.position.x > winSize.width/2.3 && cursor.position.x < winSize.width - winSize.width/2.3)
            {
                northMob.position = CGPointMake(northMob.position.x, northMob.position.y + 30);
                kills += 15;
            }
            grenadeCount -= 1;
        }
    }
    else if (CGRectContainsPoint([downButton boundingBox], touchLocation))
    {
        NSLog(@"down button touched");
        if ([equippedWeapon  isEqual:@"pistol"])
        {
            if (cursor.position.x > winSize.width/8 && cursor.position.x < winSize.width - winSize.width/8)
            {
                southMob.position = CGPointMake(southMob.position.x, southMob.position.y - 5);
                kills += 2;
            }
        }
        else if ([equippedWeapon isEqualToString:@"shotgun"] && shotgunAmmo > 0)
        {
            if (cursor.position.x > winSize.width/4 && cursor.position.x < winSize.width - winSize.width/4)
            {
                southMob.position = CGPointMake(southMob.position.x, southMob.position.y - 10);
                kills += 5;
            }
            shotgunAmmo -= 1;
        }
        else if ([equippedWeapon isEqualToString:@"flamethrower"] && flamethrowerFuel > 0)
        {
            if (cursor.position.x > winSize.width/2.8 && cursor.position.x < winSize.width - winSize.width/2.8)
            {
                southMob.position = CGPointMake(southMob.position.x, southMob.position.y - 20);
                kills += 10;
            }
            flamethrowerFuel -= 1;
        }
        else if ([equippedWeapon isEqualToString:@"grenade"] && grenadeCount > 0)
        {
            if (cursor.position.x > winSize.width/2.3 && cursor.position.x < winSize.width - winSize.width/2.3)
            {
                southMob.position = CGPointMake(southMob.position.x, southMob.position.y - 30);
                kills += 15;
            }
            grenadeCount -= 1;
        }
    }
    
    shotgunBullets.string = [NSString stringWithFormat:@"%i", (int)shotgunAmmo];
    flamethrowerStuff.string = [NSString stringWithFormat:@"%i", (int)flamethrowerFuel];
    grenadeNumber.string = [NSString stringWithFormat:@"%i", (int)grenadeCount];
    currentScore.string = [NSString stringWithFormat:@"%i", (int)kills];
    
    if (gameOverNode.visible == YES)
    {
        [self again];
    }
}

- (void) update:(CCTime)delta
{
    
    CGPoint velocityUp = CGPointMake(0, 0.1); // Move up
    CGPoint velocityDown = CGPointMake(0, -0.1); // Move down
    CGPoint velocityRight = CGPointMake(0.1, 0); // Move right
    CGPoint velocityLeft = CGPointMake(-0.1, 0); // Move left
    
    CGPoint velocityCursorRight = CGPointMake(cursorSpeedRight, 0);
    CGPoint velocityCursorLeft = CGPointMake(cursorSpeedLeft,0);
    
    southMob.position = ccpAdd(southMob.position, velocityUp);
    northMob.position = ccpAdd(northMob.position, velocityDown);
    westMob.position = ccpAdd(westMob.position, velocityRight);
    eastMob.position = ccpAdd(eastMob.position, velocityLeft);
    
    //MOVE CURSOR
    if (didHitSide == YES)
    {
        cursor.position = ccpAdd(cursor.position, velocityCursorRight);
        if (cursor.position.x >= winSize.width)
        {
            didHitSide = NO;
            cursorSpeedRight += 0.5;
        }
    }
    else if (didHitSide == NO)
    {
        cursor.position = ccpAdd(cursor.position, velocityCursorLeft);
        if (cursor.position.x <= 0)
        {
            didHitSide = YES;
            cursorSpeedLeft -= 0.5;
        }
    }
}

- (void) gameOver
{
    gameOverNode.visible = YES;
    hunter.visible = NO;
    endScore.string = [NSString stringWithFormat:@"%i", (int)kills];
    
    if (kills > previousHighScore || previousHighScore == 0)
    {
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        [prefs setInteger:previousHighScore forKey:@"highscore"];
        [prefs synchronize];
        highScore.string = [NSString stringWithFormat:@"%i", (int)kills];
    }
}

#pragma COLLISIONS
//ZOMBIES DON'T CARE ABOUT EACH OTHER
- (BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair northMob:(CCNode *)nodeA westMob:(CCNode *)nodeB
{
    return FALSE;
}

- (BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair northMob:(CCNode *)nodeA eastMob:(CCNode *)nodeB
{
    return FALSE;
}

- (BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair southMob:(CCNode *)nodeA westMob:(CCNode *)nodeB
{
    return FALSE;
}

- (BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair southMob:(CCNode *)nodeA eastMob:(CCNode *)nodeB
{
    return FALSE;
}

- (BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair southMob:(CCNode *)nodeA northMob:(CCNode *)nodeB
{
    return FALSE;
}

- (BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair eastMob:(CCNode *)nodeA westMob:(CCNode *)nodeB
{
    return FALSE;
}

//YOU DEAD
- (BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair hunter:(CCNode *)nodeA wildcard:(CCNode *)nodeB
{
    NSLog(@"dead");
    [self gameOver];
    return FALSE;
}

- (void) again
{
    NSLog(@"AGAIN");
    CCScene *again = [CCBReader loadAsScene:@"MainScene"];
    CCTransition *transition = [CCTransition transitionFadeWithDuration:0.1f];
    [[CCDirector sharedDirector] replaceScene:again withTransition:transition];
}

@end
