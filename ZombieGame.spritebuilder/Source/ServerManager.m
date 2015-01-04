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
    
    NSURL *url = [NSURL URLWithString:@"shrouded-plains-6422.herokuapp.com/score"];
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
