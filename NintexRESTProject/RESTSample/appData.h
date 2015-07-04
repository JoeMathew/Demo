//
//  appData.h
//  RESTSample
//
//  Created by Joe Mathew on 26/06/2015.
//  Copyright (c) 2015 Joe Mathew. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface appData : NSObject {
}

@property(nonatomic, retain) NSMutableArray *flightsList;

+ (id)sharedInstance;

@end
