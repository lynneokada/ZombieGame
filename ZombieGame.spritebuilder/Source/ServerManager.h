//
//  ServerManager.h
//  Zombie Mob
//
//  Created by Lynne Okada on 1/4/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MainScene.h"

@interface ServerManager : NSObject <NSURLSessionDataDelegate>

+ (instancetype) sharedManager;

- (void) postScore:(NSString *)score andusername:(NSString *)username;

@end
