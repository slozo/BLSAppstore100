//
//  BLSDataStorage.m
//  BLSAppStore100
//
//  Created by MATEUSZ SZLOSEK on 09.04.2014.
//  Copyright (c) 2014 MATEUSZ SZLOSEK. All rights reserved.
//

#import "BLSDataStorage.h"

@implementation BLSDataStorage 

-(void)dealloc
{
    if (_dataArray)
    {
        [_dataArray release];
    }
    
    [super dealloc];
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"dataArray": @"entry",
             };
}


@end
