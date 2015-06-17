//
//  HTHotelsViewController.m
//  SampleNSUserActivityApp
//
//  Created by Doug Suriano on 6/17/15.
//  Copyright © 2015 HotelTonight. All rights reserved.
//

#import "HTHotelsViewController.h"
#import "HTCitiesViewController.h"
#import "HTUserActivityManager.h"

static NSString * const kTableViewCellReuseIdentifier = @"kTableViewCellReuseIdentifier";

@interface HTHotelsViewController () <HTCitiesViewControllerDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, copy) NSArray *hotelList;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation HTHotelsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *citiesBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cities" style:UIBarButtonItemStylePlain target:self action:@selector(citiesButtonPressed:)];
    self.navigationItem.leftBarButtonItem = citiesBarButtonItem;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_tableView);
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_tableView]|"
                                                                           options:0
                                                                           metrics:nil
                                                                             views:views]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_tableView]|"
                                                                           options:0
                                                                           metrics:nil
                                                                             views:views]];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kTableViewCellReuseIdentifier];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)citiesButtonPressed:(id)sender
{
    HTCitiesViewController *citiesVc = [[HTCitiesViewController alloc] initWithNibName:nil bundle:nil];
    citiesVc.delegate = self;
    [self presentViewController:citiesVc animated:YES completion:nil];
}

#pragma mark - HTCitiesViewControllerDelegate
- (void)citiesViewController:(HTCitiesViewController *)controller userDidSelectCityNamed:(NSString *)city
{
    self.navigationItem.title = city;
    self.hotelList = [self randomHotelList];
    [self.tableView reloadData];
    
    [[HTUserActivityManager sharedManager] registerMarkedViewedWithName:city];
}

#pragma mark - Data mocking
- (NSString *)randomHotelName
{
    NSArray *hotelNames = @[@"Grand Hotel Budapest", @"The Overlook", @"The Plaza", @"Bates Motel", @"Awesome Hotel", @"Cool Hotel", @"Swanky Hotel", @"Underwater Hotel", @"Cooler Hotel", @"NSHotel", @"Free Pizza Inn", @"Hotel with awesome bar", @"Hotel that has great wings", @"Cheap Hotel", @"Dance Party Inn", @"Grand Funkadellic Hotel", @"Burning Man", @"Taco Tuesday Inn", @"Hotel California", @"Heartbreak Hotel", @"Blue Hotel", @"Nice Hotel"];
    NSUInteger randomIndex =  arc4random_uniform((u_int32_t)[hotelNames count]);
    return hotelNames[randomIndex];
}

- (NSArray *)randomHotelList
{
    NSMutableArray *list = [[NSMutableArray alloc] initWithCapacity:10];
    
    for (NSInteger i = 0; i < 10; i++) {
        list[i] = [self randomHotelName];
    }
    
    return [list copy];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(nonnull UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.hotelList count];
}

- (UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kTableViewCellReuseIdentifier forIndexPath:indexPath];
    cell.textLabel.text = self.hotelList[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(nonnull UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    return 200.0f;
}

- (void)tableView:(nonnull UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
