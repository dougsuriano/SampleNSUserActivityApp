//
//  HTCitiesViewController.h
//  SampleNSUserActivityApp
//
//  Created by Doug Suriano on 6/17/15.
//  Copyright © 2015 HotelTonight. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HTCitiesViewController;

@protocol HTCitiesViewControllerDelegate <NSObject>

@required
- (void)citiesViewController:(HTCitiesViewController *)controller userDidSelectCityNamed:(NSString *)city;

@end

@interface HTCitiesViewController : UIViewController

@property (nonatomic, weak) id<HTCitiesViewControllerDelegate> delegate;

@end
