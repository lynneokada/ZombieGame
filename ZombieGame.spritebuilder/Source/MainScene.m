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
    
    CCNode *southMob;
    CCNode *northMob;
    CCNode *westMob;
    CCNode *eastMob;
    CCNode *hunter;
}

- (void) didLoadFromCCB
{
    self.userInteractionEnabled = TRUE;
    gameOverNode.visible = NO;
    physicsNode.collisionDelegate = self;
    physicsNode.debugDraw = YES;
    
    northMob.physicsBody.collisionType = @"northMob";
    southMob.physicsBody.collisionType = @"southMob";
    westMob.physicsBody.collisionType = @"westMob";
    eastMob.physicsBody.collisionType = @"eastMob";
    hunter.physicsBody.collisionType = @"hunter";
    
    winSize = [CCDirector sharedDirector].viewSize;
}

- (void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint touchLocation = [touch locationInNode:selectionNode];
    
    //SHOOT DIRECTION
    if (CGRectContainsPoint([leftButton boundingBox], touchLocation))
    {
        NSLog(@"left button touched");
        westMob.position = ccpSub(westMob.position, CGPointMake(-0.5,0));
    } else if (CGRectContainsPoint([rightButton boundingBox], touchLocation))
    {
        NSLog(@"right button touched");
    } else if (CGRectContainsPoint([upButton boundingBox], touchLocation))
    {
        NSLog(@"up button touched");
    } else if (CGRectContainsPoint([downButton boundingBox], touchLocation))
    {
        NSLog(@"down button touched");
    }
    
    //WEAPON SELECTION
    if (CGRectContainsPoint([pistol boundingBox], touchLocation))
    {
        NSLog(@"pistol equipped");
    }
}

- (void) update:(CCTime)delta
{
    //float gameTime = delta;
    CGPoint velocityUp = CGPointMake(0, 0.5); // Move up
    CGPoint velocityDown = CGPointMake(0, -0.5); // Move down
    CGPoint velocityRight = CGPointMake(0.5, 0); // Move right
    CGPoint velocityLeft = CGPointMake(-0.5, 0); // Move left
    
    southMob.position = ccpAdd(southMob.position, velocityUp);
    northMob.position = ccpAdd(northMob.position, velocityDown);
    westMob.position = ccpAdd(westMob.position, velocityRight);
    eastMob.position = ccpAdd(eastMob.position, velocityLeft);
    
    //NSLog(@"southmobX: %f, southmobY: %f", southMob.position.x, southMob.position.y);
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

//SO DEAD
- (BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair hunter:(CCNode *)nodeA wildcard:(CCNode *)nodeB
{
    NSLog(@"dead");
    [self gameOver];
    return FALSE;
}

@end
