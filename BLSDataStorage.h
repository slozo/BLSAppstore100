//
//  BLSDataStorage.h
//  BLSAppStore100
//
//  Created by MATEUSZ SZLOSEK on 09.04.2014.
//  Copyright (c) 2014 MATEUSZ SZLOSEK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle.h>

@interface BLSDataStorage : MTLModel <MTLJSONSerializing>

@property (nonatomic, retain) NSArray *dataArray;

@end
