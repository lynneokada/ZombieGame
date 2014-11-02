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
    
    CCNode *pistolCursor;
    
    CCNode *southMob;
    CCNode *northMob;
    CCNode *westMob;
    CCNode *eastMob;
    CCNode *hunter;
    
    NSString *equippedWeapon;
}

- (void) didLoadFromCCB
{
    self.userInteractionEnabled = TRUE;
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
}

- (void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint touchLocation = [touch locationInNode:selectionNode];
    
    //WEAPON SELECTION
    if (CGRectContainsPoint([pistol boundingBox], touchLocation))
    {
        NSLog(@"pistol equipped");
        equippedWeapon = @"pistol";
    } else if (CGRectContainsPoint([shotgun boundingBox], touchLocation))
    {
        NSLog(@"shotgun equipped");
        equippedWeapon = @"shotgun";
    } else if (CGRectContainsPoint([flamethrower boundingBox], touchLocation))
    {
        NSLog(@"flamethrower equipped");
        equippedWeapon = @"flamethrower";
    } else if (CGRectContainsPoint([grenade boundingBox], touchLocation))
    {
        NSLog(@"grenade equipped");
        equippedWeapon = @"grenade";
    }
    
    //SHOOT DIRECTION
    if (CGRectContainsPoint([leftButton boundingBox], touchLocation))
    {
        NSLog(@"left button touched");
        if ([equippedWeapon  isEqual:@"pistol"])
        {
        westMob.position = CGPointMake(westMob.position.x - 5, westMob.position.y);
        } else if ([equippedWeapon isEqualToString:@"shotgun"])
        {
            westMob.position = CGPointMake(westMob.position.x - 10, westMob.position.y);
        } else if ([equippedWeapon isEqualToString:@"flamethrower"])
        {
            westMob.position = CGPointMake(westMob.position.x - 20, westMob.position.y);
        } else if ([equippedWeapon isEqualToString:@"grenade"])
        {
            westMob.position = CGPointMake(westMob.position.x - 30, westMob.position.y);
        }
    } else if (CGRectContainsPoint([rightButton boundingBox], touchLocation))
    {
        NSLog(@"right button touched");
        if ([equippedWeapon  isEqual:@"pistol"])
        {
            eastMob.position = CGPointMake(eastMob.position.x + 5, eastMob.position.y);
        } else if ([equippedWeapon isEqualToString:@"shotgun"])
        {
            eastMob.position = CGPointMake(eastMob.position.x + 10, eastMob.position.y);
        } else if ([equippedWeapon isEqualToString:@"flamethrower"])
        {
            eastMob.position = CGPointMake(eastMob.position.x + 20, eastMob.position.y);
        } else if ([equippedWeapon isEqualToString:@"grenade"])
        {
            eastMob.position = CGPointMake(eastMob.position.x + 30, eastMob.position.y);
        }
    } else if (CGRectContainsPoint([upButton boundingBox], touchLocation))
    {
        NSLog(@"up button touched");
        if ([equippedWeapon  isEqual:@"pistol"])
        {
            northMob.position = CGPointMake(northMob.position.x, northMob.position.y + 5);
        } else if ([equippedWeapon isEqualToString:@"shotgun"])
        {
            northMob.position = CGPointMake(northMob.position.x, northMob.position.y + 10);
        } else if ([equippedWeapon isEqualToString:@"flamethrower"])
        {
            northMob.position = CGPointMake(northMob.position.x, northMob.position.y + 20);
        } else if ([equippedWeapon isEqualToString:@"grenade"])
        {
            northMob.position = CGPointMake(northMob.position.x, northMob.position.y + 30);
        }
    } else if (CGRectContainsPoint([downButton boundingBox], touchLocation))
    {
        NSLog(@"down button touched");
        if ([equippedWeapon  isEqual:@"pistol"])
        {
            southMob.position = CGPointMake(southMob.position.x, southMob.position.y - 5);
        } else if ([equippedWeapon isEqualToString:@"shotgun"])
        {
            southMob.position = CGPointMake(southMob.position.x, southMob.position.y - 10);
        } else if ([equippedWeapon isEqualToString:@"flamethrower"])
        {
            southMob.position = CGPointMake(southMob.position.x, southMob.position.y - 20);
        } else if ([equippedWeapon isEqualToString:@"grenade"])
        {
            southMob.position = CGPointMake(southMob.position.x, southMob.position.y - 30);
        }
    }
}

- (void) update:(CCTime)delta
{
    //float gameTime = delta;
    CGPoint velocityUp = CGPointMake(0, 0.1); // Move up
    CGPoint velocityDown = CGPointMake(0, -0.1); // Move down
    CGPoint velocityRight = CGPointMake(0.1, 0); // Move right
    CGPoint velocityLeft = CGPointMake(-0.1, 0); // Move left
    
    southMob.position = ccpAdd(southMob.position, velocityUp);
    northMob.position = ccpAdd(northMob.position, velocityDown);
    westMob.position = ccpAdd(westMob.position, velocityRight);
    eastMob.position = ccpAdd(eastMob.position, velocityLeft);
    
}

- (void) gameOver
{
    gameOverNode.visible = YES;
    hunter.visible = NO;
    
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

@end
