//
//  BLSJSONFether.m
//  BLSAppStore100
//
//  Created by MATEUSZ SZLOSEK on 09.04.2014.
//  Copyright (c) 2014 MATEUSZ SZLOSEK. All rights reserved.
//

#import "BLSJSONFether.h"
#import <TSMessage.h>
#import "BLSDataStorage.h"

@interface BLSJSONFether()

@property (nonatomic, retain) NSURLSession *session;
@property (nonatomic, assign) BLSDataStorage *dataStorage;

@end

@implementation BLSJSONFether

-(void)dealloc
{
    if (_session)
    {
        [_session release];
    }
    
    [super dealloc];
}

- (id)init {
    if (self = [super init]) {
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        _session = [NSURLSession sessionWithConfiguration:config];
    }
    return self;
}


-(BOOL)fetchJSON
{
    NSLog(@"Fetching JSON.");
    
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithURL:[NSURL URLWithString:@"https://itunes.apple.com/us/rss/toppaidapplications/limit=100/json"] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
    {
        NSLog(@"task completed.");
        
        if (! error) {
            
            NSLog(@"No error");
            NSError *jsonError = nil;
            id json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonError];
            
            NSLog(@"response: %@", json);
            if (! jsonError) {
               [TSMessage showNotificationWithTitle:@"Data Received." subtitle:@"" type:TSMessageNotificationTypeSuccess];
               
                
               self.dataStorage = [MTLJSONAdapter modelOfClass:[BLSDataStorage class] fromJSONDictionary:json error:nil];
                
            }
        }
        else {
            NSLog(@"error");
            
           [TSMessage showNotificationWithTitle:@"Can't fetch data." subtitle:@"" type:TSMessageNotificationTypeError];
        }
    }];
    
    [dataTask resume];
    
    return YES;
}

@end
