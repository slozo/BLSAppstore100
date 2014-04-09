//
//  BLSJSONFether.h
//  BLSAppStore100
//
//  Created by MATEUSZ SZLOSEK on 09.04.2014.
//  Copyright (c) 2014 MATEUSZ SZLOSEK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle.h>

@class BLSManager;

@interface BLSJSONFether : NSObject

@property (nonatomic, assign) BLSManager *manager;

-(BOOL)fetchJSON;

@end
