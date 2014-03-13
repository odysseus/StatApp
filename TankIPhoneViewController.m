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
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, 120)];
    [header setBackgroundColor:[UIColor whiteColor]];
    
    [format addLabelToView:header
                 withFrame:CGRectMake(origin.x, origin.y, width, 30)
                      text:tank.name
                  fontSize:(format.fontSize * 1.5)
                 fontColor:format.darkColor
          andTextAlignment:NSTextAlignmentCenter];
    
    origin.y += 40;
    SelectorView *selectorView = [[SelectorView alloc] initForIPhoneWithOrigin:origin andTank:tank];
    [selectorView setTankViewController:self];
    [header addSubview:selectorView];
    
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
    NSString *key = attArr[indexPath.row][0];
    NSString *name = [NSString stringWithFormat:@"%@", attArr[indexPath.row][1]];
    

    
    // Int and float keys should be displayed differently
    // Create a list of float keys to check against the cell key
    NSArray *floatKeys = @[@"accuracy", @"aimTime", @"rateOfFire", @"timeBetweenShots", @"specificPower",
                           @"loadLimit", @"camoValue", @"fireChance"];
    NSNumber *valueNum = [NSNumber numberWithFloat:[[tank valueForKey:key] floatValue]];
    NSString *value = [[NSString alloc] init];
    // If the cell key is a float, then format the string as such
    // otherwise it will be formatted as an int
    if ([floatKeys containsObject:key]) {
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
        average = @"--";
    } else {
        // If it does need an average, fetch it, then figure out whether it needs to be formatted
        // as an int or as a float
        averageNum = [NSNumber numberWithFloat:[[tank.averageTank valueForKey:key] floatValue]];
        if ([floatKeys containsObject:key]) {
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
    // Fetching the key
    NSString *key = attArr[indexPath.row][0];
    // Retrieve the data from the tooltips store
    RCToolTips *tooltips = [RCToolTips store];
    NSArray *data = [tooltips valuesForKey:key];
    
    // Create a VC to display the stat information
    UIViewController *statView = [[UIViewController alloc] init];
    [[statView view] setBackgroundColor:[UIColor whiteColor]];
    
    [format addLabelToView:[statView view]
                 withFrame:CGRectMake((format.screenWidth - 200) / 2, 80, 200, 44)
                      text:data[0]
                  fontSize:format.fontSize * 1.5
                 fontColor:format.darkColor
          andTextAlignment:NSTextAlignmentCenter];
    
    // Text view with the stat description
    UITextView *textField = [[UITextView alloc]
                             initWithFrame:CGRectMake((format.screenWidth - 300) / 2, 130, 300, 300)];
    [textField setText:data[2]];
    [textField setFont:[UIFont systemFontOfSize:format.fontSize]];
    [textField setTextColor:format.darkColor];
    [textField setUserInteractionEnabled:NO];
    
    [[statView view] addSubview:textField];
    
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
    
    // Create a view to add the button to
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, width, 44)];
    [headerView setBackgroundColor:[UIColor whiteColor]];
    
    // Create and format the button
    RCButton *button = [[RCButton alloc] initWithFrame:CGRectMake(10, 0, width, 42)];
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

@end
