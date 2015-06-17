//
//  HTCitiesViewController.m
//  SampleNSUserActivityApp
//
//  Created by Doug Suriano on 6/17/15.
//  Copyright © 2015 HotelTonight. All rights reserved.
//

#import "HTCitiesViewController.h"
#import "HTUserActivityManager.h"

static NSString * const kTableViewCellReuseIdentifier = @"kTableViewCellReuseIdentifier";

@interface HTCitiesViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation HTCitiesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kTableViewCellReuseIdentifier];
    
    [self.tableView reloadData];
    
    [[HTUserActivityManager sharedManager] invalidateAllUserActivity];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(nonnull UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self cities] count];
}

- (UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kTableViewCellReuseIdentifier forIndexPath:indexPath];
    cell.textLabel.text = [[self cities] objectAtIndex:indexPath.row];
    return cell;
    
}

#pragma mark - UITableViewDelegate
- (void)tableView:(nonnull UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    NSString *cityName = [[self cities] objectAtIndex:indexPath.row];
    [self.delegate citiesViewController:self userDidSelectCityNamed:cityName];
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (NSArray *)cities
{
    return @[@"Aberdeen",@"Abilene",@"Akron",@"Albany",@"Albuquerque",@"Alexandria",@"Allentown",@"Amarillo",@"Anaheim",@"Anchorage",@"Ann Arbor",@"Antioch",@"Apple Valley",@"Appleton",@"Arlington",@"Arvada",@"Asheville",@"Athens",@"Atlanta",@"Atlantic City",@"Augusta",@"Aurora",@"Austin",@"Bakersfield",@"Baltimore",@"Barnstable",@"Baton Rouge",@"Beaumont",@"Bel Air",@"Bellevue",@"Berkeley",@"Bethlehem",@"Billings",@"Birmingham",@"Bloomington",@"Boise",@"Boise City",@"Bonita Springs",@"Boston",@"Boulder",@"Bradenton",@"Bremerton",@"Bridgeport",@"Brighton",@"Brownsville",@"Bryan",@"Buffalo",@"Burbank",@"Burlington",@"Cambridge",@"Canton",@"Cape Coral",@"Carrollton",@"Cary",@"Cathedral City",@"Cedar Rapids",@"Champaign",@"Chandler",@"Charleston",@"Charlotte",@"Chattanooga",@"Chesapeake",@"Chicago",@"Chula Vista",@"Cincinnati",@"Clarke County",@"Clarksville",@"Clearwater",@"Cleveland",@"College Station",@"Colorado Springs",@"Columbia",@"Columbus",@"Concord",@"Coral Springs",@"Corona",@"Corpus Christi",@"Costa Mesa",@"Dallas",@"Daly City",@"Danbury",@"Davenport",@"Davidson County",@"Dayton",@"Daytona Beach",@"Deltona",@"Denton",@"Denver",@"Des Moines",@"Detroit",@"Downey",@"Duluth",@"Durham",@"El Monte",@"El Paso",@"Elizabeth",@"Elk Grove",@"Elkhart",@"Erie",@"Escondido",@"Eugene",@"Evansville",@"Fairfield",@"Fargo",@"Fayetteville",@"Fitchburg",@"Flint",@"Fontana",@"Fort Collins",@"Fort Lauderdale",@"Fort Smith",@"Fort Walton Beach",@"Fort Wayne",@"Fort Worth",@"Frederick",@"Fremont",@"Fresno",@"Fullerton",@"Gainesville",@"Garden Grove",@"Garland",@"Gastonia",@"Gilbert",@"Glendale",@"Grand Prairie",@"Grand Rapids",@"Grayslake",@"Green Bay",@"GreenBay",@"Greensboro",@"Greenville",@"Gulfport-Biloxi",@"Hagerstown",@"Hampton",@"Harlingen",@"Harrisburg",@"Hartford",@"Havre de Grace",@"Hayward",@"Hemet",@"Henderson",@"Hesperia",@"Hialeah",@"Hickory",@"High Point",@"Hollywood",@"Honolulu",@"Houma",@"Houston",@"Howell",@"Huntington",@"Huntington Beach",@"Huntsville",@"Independence",@"Indianapolis",@"Inglewood",@"Irvine",@"Irving",@"Jackson",@"Jacksonville",@"Jefferson",@"Jersey City",@"Johnson City",@"Joliet",@"Kailua",@"Kalamazoo",@"Kaneohe",@"Kansas City",@"Kennewick",@"Kenosha",@"Killeen",@"Kissimmee",@"Knoxville",@"Lacey",@"Lafayette",@"Lake Charles",@"Lakeland",@"Lakewood",@"Lancaster",@"Lansing",@"Laredo",@"Las Cruces",@"Las Vegas",@"Layton",@"Leominster",@"Lewisville",@"Lexington",@"Lincoln",@"Little Rock",@"Long Beach",@"Lorain",@"Los Angeles",@"Louisville",@"Lowell",@"Lubbock",@"Macon",@"Madison",@"Manchester",@"Marina",@"Marysville",@"McAllen",@"McHenry",@"Medford",@"Melbourne",@"Memphis",@"Merced",@"Mesa",@"Mesquite",@"Miami",@"Milwaukee",@"Minneapolis",@"Miramar",@"Mission Viejo",@"Mobile",@"Modesto",@"Monroe",@"Monterey",@"Montgomery",@"Moreno Valley",@"Murfreesboro",@"Murrieta",@"Muskegon",@"Myrtle Beach",@"Naperville",@"Naples",@"Nashua",@"Nashville",@"New Bedford",@"New Haven",@"New London",@"New Orleans",@"New York",@"New York City",@"Newark",@"Newburgh",@"Newport News",@"Norfolk",@"Normal",@"Norman",@"North Charleston",@"North Las Vegas",@"North Port",@"Norwalk",@"Norwich",@"Oakland",@"Ocala",@"Oceanside",@"Odessa",@"Ogden",@"Oklahoma City",@"Olathe",@"Olympia",@"Omaha",@"Ontario",@"Orange",@"Orem",@"Orlando",@"Overland Park",@"Oxnard",@"Palm Bay",@"Palm Springs",@"Palmdale",@"Panama City",@"Pasadena",@"Paterson",@"Pembroke Pines",@"Pensacola",@"Peoria",@"Philadelphia",@"Phoenix",@"Pittsburgh",@"Plano",@"Pomona",@"Pompano Beach",@"Port Arthur",@"Port Orange",@"Port Saint Lucie",@"Port St. Lucie",@"Portland",@"Portsmouth",@"Poughkeepsie",@"Providence",@"Provo",@"Pueblo",@"Punta Gorda",@"Racine",@"Raleigh",@"Rancho Cucamonga",@"Reading",@"Redding",@"Reno",@"Richland",@"Richmond",@"Richmond County",@"Riverside",@"Roanoke",@"Rochester",@"Rockford",@"Roseville",@"Round Lake Beach",@"Sacramento",@"Saginaw",@"Saint Louis",@"Saint Paul",@"Saint Petersburg",@"Salem",@"Salinas",@"Salt Lake City",@"San Antonio",@"San Bernardino",@"San Buenaventura",@"San Diego",@"San Francisco",@"San Jose",@"Santa Ana",@"Santa Barbara",@"Santa Clara",@"Santa Clarita",@"Santa Cruz",@"Santa Maria",@"Santa Rosa",@"Sarasota",@"Savannah",@"Scottsdale",@"Scranton",@"Seaside",@"Seattle",@"Sebastian",@"Shreveport",@"Simi Valley",@"Sioux City",@"Sioux Falls",@"South Bend",@"South Lyon",@"Spartanburg",@"Spokane",@"Springdale",@"Springfield",@"St. Louis",@"St. Paul",@"St. Petersburg",@"Stamford",@"Sterling Heights",@"Stockton",@"Sunnyvale",@"Syracuse",@"Tacoma",@"Tallahassee",@"Tampa",@"Temecula",@"Tempe",@"Thornton",@"Thousand Oaks",@"Toledo",@"Topeka",@"Torrance",@"Trenton",@"Tucson",@"Tulsa",@"Tuscaloosa",@"Tyler",@"Utica",@"Vallejo",@"Vancouver",@"Vero Beach",@"Victorville",@"Virginia Beach",@"Visalia",@"Waco",@"Warren",@"Washington",@"Waterbury",@"Waterloo",@"West Covina",@"West Valley City",@"Westminster",@"Wichita",@"Wilmington",@"Winston",@"Winter Haven",@"Worcester",@"Yakima",@"Yonkers",@"York",@"Youngstown"];
}



@end
