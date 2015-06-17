//
//  HTUserActivityManager.m
//  SampleNSUserActivityApp
//
//  Created by Doug Suriano on 6/17/15.
//  Copyright © 2015 HotelTonight. All rights reserved.
//

#import "HTUserActivityManager.h"
#import <MobileCoreServices/MobileCoreServices.h>

@import CoreSpotlight;

@interface HTUserActivityManager ()

@property (nonatomic, strong) NSUserActivity *currentActivity;

@end

@implementation HTUserActivityManager

+ (instancetype)sharedManager
{
    static HTUserActivityManager *_manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[HTUserActivityManager alloc] init];
    });
    
    return _manager;
}

- (void)registerMarkedViewedWithName:(NSString *)market
{
    NSString *activityTitle = [NSString stringWithFormat:@"Hotels in %@", market];
    
    if ([activityTitle isEqualToString:self.currentActivity.title])
    {
        return;
    }
    
    NSString *bundleName = [[NSBundle mainBundle] bundleIdentifier];
    NSString *activityName = [bundleName stringByAppendingString:@".market_viewed"];
    
    NSUserActivity *userActivity = [[NSUserActivity alloc] initWithActivityType:activityName];
    userActivity.title = activityTitle;
    userActivity.eligibleForPublicIndexing = YES;
    userActivity.eligibleForSearch = YES;
    userActivity.eligibleForHandoff = NO;
    userActivity.userInfo = @{@"market_name" : market};
    userActivity.keywords = [NSSet setWithArray:@[market, @"hotels", @"Hotel"]];
    
    CSSearchableItemAttributeSet *attributeSet = [[CSSearchableItemAttributeSet alloc] initWithItemContentType:(NSString *)kUTTypeApplicationBundle];
    attributeSet.title = userActivity.title;
    attributeSet.contentDescription = [NSString stringWithFormat:@"Hotels available in scenic %@", market];
    attributeSet.keywords = [userActivity.keywords allObjects];
    userActivity.contentAttributeSet = attributeSet;
    
    self.currentActivity = userActivity;
}

- (void)setCurrentActivity:(NSUserActivity *)currentActivity
{
    @synchronized(self) {
        [_currentActivity invalidate];
        _currentActivity = currentActivity;
        [_currentActivity becomeCurrent];
    }
}

- (void)invalidateAllUserActivity
{
    [self.currentActivity invalidate];
}

@end
