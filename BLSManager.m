//
//  BLSManager.m
//  BLSAppStore100
//
//  Created by MATEUSZ SZLOSEK on 09.04.2014.
//  Copyright (c) 2014 MATEUSZ SZLOSEK. All rights reserved.
//

#import "BLSManager.h"
#import "BLSJSONFether.h"

@interface BLSManager()

@property (nonatomic, retain) BLSJSONFether* jsonFetcher;

@end

@implementation BLSManager


+ (instancetype)sharedManager {
    static id _sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[self alloc] init];
    });
    
    return _sharedManager;
}   

- (id)init {
    if (self = [super init]) {
        
        _jsonFetcher = [[BLSJSONFether alloc] init];
        
       BOOL success = [self fetchData];
        if (!success)
        {
            NSLog(@"error fething data");
        }
    }
    return self;
}

-(BOOL)fetchData
{
    [self.jsonFetcher fetchJSON];
    
    return YES;
}

@end
