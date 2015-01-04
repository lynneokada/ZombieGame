//
//  ServerManager.m
//  Zombie Mob
//
//  Created by Lynne Okada on 1/4/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "ServerManager.h"

@implementation ServerManager

+ (instancetype) sharedManager
{
    static ServerManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}

- (instancetype) init
{
    if (self = [super init])
    {
        
    }
    return self;
}

- (void) postScore:(NSString *)score andusername:(NSString *)username
{
    NSLog(@"NAME:%@, SCORE:%@", username,score);
    NSDictionary *post = @{
                            @"username":username,
                            @"score":score
                            };
    
    NSURL *url = [NSURL URLWithString:@"https://zombie-mob.herokuapp.com/score"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30.0];
    [request setHTTPMethod:@"POST"];
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:post options:0 error:nil];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *urlSession = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
    
    NSURLSessionUploadTask *dataUpload = [urlSession uploadTaskWithRequest:request fromData:jsonData completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
        NSInteger responseStatusCode = [httpResponse statusCode];
        
        if (responseStatusCode == 200)
        {
            NSArray *downloadedJSON = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSLog(@"%@",downloadedJSON);
            

        } else {
            //error handing?
            NSLog(@"wtf");
        }
    }];
    [dataUpload resume];
}

@end
