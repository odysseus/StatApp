//
//  TankIPhoneViewController.m
//  TankCommander
//
//  Created by Ryan Case on 3/6/14.
//  Copyright (c) 2014 Ryan Case. All rights reserved.
//

#import "TankIPhoneViewController.h"
#import "Tank.h"
#import "AverageTank.h"
#import "ModulesViewController.h"
#import "RCButton.h"
#import "StatCell.h"
#import "RCFormatting.h"
#import "SelectorView.h"
#import "RCToolTips.h"
#import "TiersViewController.h"
#import "StatStore.h"
#import "Stat.h"

@interface TankIPhoneViewController ()

@end

@implementation TankIPhoneViewController

@synthesize tank, turretedIndex, nonTurretedIndex, format;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        self.turretedIndex = @[@"gun", @"hull", @"turret", @"suspension", @"engine", @"radio"];
        self.nonTurretedIndex = @[@"gun", @"hull", @"suspension", @"engine", @"radio"];
        self.format = [RCFormatting store];
        self.tooltips = [RCToolTips store];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Load the nib file
    UINib *nib = [UINib nibWithNibName:@"StatCell" bundle:nil];
    
    // Register this NIB which contains the cell
    [[self tableView] registerNib:nib
           forCellReuseIdentifier:@"StatCell"];
    
    UIBarButtonItem *tankCompare = [[UIBarButtonItem alloc] initWithTitle:@"Compare"
                                                                    style:UIBarButtonItemStyleBordered
                                                                   target:self
                                                                   action:@selector(tankCompare)];
    [self.navigationItem setRightBarButtonItem:tankCompare];
    
    // Reload data to deal with changed modules, etc.
    [self.tableView reloadData];
    
    // Adding the Header
    self.tableView.tableHeaderView = [self tableHeaderView];
}

- (UIView *)tableHeaderView
{
    CGPoint origin = CGPointMake(0, 10);
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    if (UIDeviceOrientationIsLandscape([[UIDevice currentDevice] orientation])) {
        origin.x += 120;
    }
    
    // Container view
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, 160)];
    [header setBackgroundColor:[UIColor whiteColor]];
    
    // Tank Name
    [format addLabelToView:header
                 withFrame:CGRectMake(origin.x, origin.y, width, 40)
                      text:tank.name
                  fontSize:(format.fontSize * 1.5)
                 fontColor:format.darkColor
          andTextAlignment:NSTextAlignmentCenter];
    
    origin.y += 25;
    
    [format addLabelToView:header
                 withFrame:CGRectMake(origin.x, origin.y, width, 32)
                      text:tank.stringNationalityAndType
                  fontSize:format.fontSize * 0.8
                 fontColor:format.lightColor
          andTextAlignment:NSTextAlignmentCenter];
    
    origin.y += 25;
    
    // UISegmentedControllers to select shell type and stock or top values
    SelectorView *selectorView = [[SelectorView alloc] initForIPhoneWithOrigin:origin andTank:tank];
    [selectorView setTankViewController:self];
    [header addSubview:selectorView];
    
    origin.y += 75;
    
    UILabel *weightLimit = [format addLabelToView:header
                                        withFrame:CGRectMake(origin.x + 10, origin.y, 200, 24)
                                             text:[NSString stringWithFormat:@"Weight/Limit: %0.2f/%0.2f", tank.weight, tank.loadLimit]
                                         fontSize:format.fontSize * 0.8
                                        fontColor:format.darkColor
                                 andTextAlignment:NSTextAlignmentLeft];
    // Conditional sets the text to red if the tank is over the suspension weight limit
    if (tank.weight < tank.loadLimit) {
        [weightLimit setTextColor:format.darkGreenColor];
    } else {
        [weightLimit setTextColor:[UIColor redColor]];
    }
    
    // Number formatter to pretty-print the price of the tank
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setGroupingSeparator:[[NSLocale currentLocale] objectForKey:NSLocaleGroupingSeparator]];
    [numberFormatter setGroupingSize:3];
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    
    UILabel *costLabel = [format addLabelToView:header
                                      withFrame:CGRectMake(origin.x + 210, origin.y, 100, 24)
                                           text:[NSString stringWithFormat:@"Price: %@",
                                                 [numberFormatter stringFromNumber:
                                                  [NSNumber numberWithInteger:tank.cost]]]
                                       fontSize:format.fontSize * 0.8
                                      fontColor:format.darkColor
                               andTextAlignment:NSTextAlignmentRight];
    // Set the price color depending on whether it is a premium or a normal tank
    if (tank.premiumTank) {
        [costLabel setTextColor:[UIColor orangeColor]];
    } else {
        [costLabel setTextColor:format.lightColor];
    }
    // Finally, if the tank is premium but not in the shop, show the price as blue rather than gold
    if (!tank.available && tank.premiumTank) {
        [costLabel setTextColor:[UIColor colorWithRed:0.0 green:0.0 blue:1.0 alpha:0.6]];
    }
    
    return header;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return self.tank.equippedModulesNameArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSDictionary *tankHash = tank.attributesHash;
    if (tank.hasTurret) {
        NSArray *modArr = [tankHash valueForKey:turretedIndex[section]];
        return [modArr count];
    } else {
        NSArray *modArr = [tankHash valueForKey:nonTurretedIndex[section]];
        return [modArr count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"StatCell";
    StatCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    NSDictionary *tankHash = tank.attributesHash;
    NSArray *attArr = [[NSArray alloc] init];
    if (tank.hasTurret) {
        attArr = [tankHash objectForKey:turretedIndex[indexPath.section]];
    } else {
        attArr = [tankHash objectForKey:nonTurretedIndex[indexPath.section]];
    }
    // Fetching the key and HR variant
    NSString *key = attArr[indexPath.row];
    NSArray *keyArr = [self.tooltips valuesForKey:key];
    NSString *name = keyArr[1];
    
    // Grab the value from the tank, stored in an NSNumber
    NSNumber *valueNum = [NSNumber numberWithFloat:[[tank valueForKey:key] floatValue]];
    // Create an empty string to hold the formatted value
    NSString *value = [[NSString alloc] init];
    
    if ([keyArr[2] isEqualToString:@"float"]) {
        value = [NSString stringWithFormat:@"%0.2f", [valueNum floatValue]];
    } else {
        value = [NSString stringWithFormat:@"%ld", (long)[valueNum integerValue]];
    }
    
    // Autoloaders have stats that don't need averages, the following code ensures that they don't
    // cause an error by trying to retrieve a nonexistent value from the average tank
    
    // List of keys that don't need average values
    NSArray *noAverages = @[@"roundsInDrum", @"drumReload", @"burstDamage", @"timeBetweenShots", @"loadLimit"];
    // Test for array inclusion, if the key is not present then it needs an average value displayed
    BOOL needsAverage = YES;
    if ([noAverages containsObject:key]) {
        needsAverage = NO;
    }
    
    // Conditional sets the average value string based on the result of the above loop
    NSNumber *averageNum = [[NSNumber alloc] init];
    NSString *average = [[NSString alloc] init];
    if (!needsAverage) {
        // Doesn't need an average, so set a placeholder string
        average = @"--";
    } else {
        // It needs an average, so fetch the number
        averageNum = [NSNumber numberWithFloat:[[tank.averageTank valueForKey:key] floatValue]];
        // And format it as an int or float, same as above
        if ([keyArr[2] isEqualToString:@"float"]) {
            average = [NSString stringWithFormat:@"%0.2f", [averageNum floatValue]];
        } else {
            average = [NSString stringWithFormat:@"%ld", (long)[averageNum integerValue]];
        }
    }
    
    // Set the fields in the cell
    [[cell stat] setText:name];
    [[cell statValue] setText:value];
    [[cell statAverage] setText:average];
    [cell setDataString:key];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Grab the data and push a viewController with the information about the stat
    NSDictionary *tankHash = tank.attributesHash;
    NSArray *attArr = [[NSArray alloc] init];
    if (tank.hasTurret) {
        attArr = [tankHash objectForKey:turretedIndex[indexPath.section]];
    } else {
        attArr = [tankHash objectForKey:nonTurretedIndex[indexPath.section]];
    }
    // Fetching the key and Stat object
    NSString *key = attArr[indexPath.row];
    Stat *stat = [[StatStore store] statForKey:key];
    
    // Generate the VC from the format method, and push it on the VC stack
    UIViewController *statView = [self.format iPhoneStatViewControllerForStat:stat];
    [self.navigationController pushViewController:statView animated:YES];
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44.0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    // Grab the array of modules for the tank
    NSArray *modArray = self.tank.equippedModulesNameArray;
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    
    // Create a view to add the button to
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, width-10, 44)];
    [headerView setBackgroundColor:[UIColor whiteColor]];
    // Expand the size when the device rotates to fit long names
    if (UIDeviceOrientationIsLandscape([[UIDevice currentDevice] orientation])) {
        headerView.frame = CGRectMake(10, 0, height-10, 44);
    }
    
    // Create and format the button
    RCButton *button = [[RCButton alloc] initWithFrame:CGRectMake(10, 0, width-10, 44)];
    if (UIDeviceOrientationIsLandscape([[UIDevice currentDevice] orientation])) {
        button.frame = CGRectMake(10, 0, height-10, 44);
    }
    [button setDataString:modArray[section][1]];
    [button setTitle:modArray[section][0] forState:UIControlStateNormal];
    [button setTitleColor:format.darkColor forState:UIControlStateNormal];
    [[button titleLabel] setFont:[UIFont systemFontOfSize:16.0]];
    [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [button setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    
    // Set the button target
    [button addTarget:self
               action:@selector(pushModulesViewController:)
     forControlEvents:UIControlEventTouchUpInside];
    
    // Add it to the container view
    [headerView addSubview:button];
    
    // and return it
    return headerView;
}

// Pushes a UITableView with the available modules when someone taps on a section header
- (void)pushModulesViewController:(RCButton *)sender
{
    NSString *key = sender.dataString;
    if (![key isEqualToString:@"hull"]) {
        ModulesViewController *mvc = [[ModulesViewController alloc] initWithTank:tank andKey:key];
        [mvc setTankViewController:self];
        [self.navigationController pushViewController:mvc animated:YES];
    }
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                duration:(NSTimeInterval)duration
{
    // Calling this to ensure the view and data reloads on rotation. Probably overkill, but the app
    // runs in such a small memory footprint anyway it's hard to justify heavy optimization
    [self viewDidLoad];
}

- (void)tankCompare
{
    TiersViewController *tvc = [[TiersViewController alloc] initForCompareWithTank:tank];
    [tvc setTankViewController:self];
    [self.navigationController pushViewController:tvc animated:YES];
}

@end
