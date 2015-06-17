//
//  HTUserActivityManager.h
//  SampleNSUserActivityApp
//
//  Created by Doug Suriano on 6/17/15.
//  Copyright © 2015 HotelTonight. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTUserActivityManager : NSObject

+ (instancetype)sharedManager;

- (void)registerMarkedViewedWithName:(NSString *)market;
- (void)invalidateAllUserActivity;


@end
