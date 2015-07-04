//
//  appData.m
//  RESTSample
//
//  Created by Joe Mathew on 26/06/2015.
//  Copyright (c) 2015 Joe Mathew. All rights reserved.
//

#import "appData.h"

@implementation appData

+ (id)sharedInstance {
    static appData *sharedData = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedData = [[self alloc] init];
        sharedData.flightsList = [[NSMutableArray alloc]init];
    });
    return sharedData;
}

- (id)init {
    if (self = [super init]) {

    }
    return self;
}

@end
