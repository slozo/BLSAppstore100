//
//  BLSManager.h
//  BLSAppStore100
//
//  Created by MATEUSZ SZLOSEK on 09.04.2014.
//  Copyright (c) 2014 MATEUSZ SZLOSEK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BLSJSONFether.h"
#import "BLSDataStorage.h"

@interface BLSManager : NSObject

@property (nonatomic, retain) BLSDataStorage *dataStorage;

+ (instancetype)sharedManager;

-(BOOL)fetchData;

@end
