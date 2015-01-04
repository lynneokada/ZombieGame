//
//  ServerManager.m
//  Zombie Mob
//
//  Created by Lynne Okada on 1/4/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "ServerManager.h"

@implementation ServerManager 

- (void) postScore:(MainScene *)score andusername:(MainScene *)username {
    NSDictionary *post = @{
                            @"username":username,
                            @"score":score
                            };
    
    
}

@end
