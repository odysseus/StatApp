//
//  TankIPhoneViewController.m
//  TankCommander
//
//  Created by Ryan Case on 3/6/14.
//  Copyright (c) 2014 Ryan Case. All rights reserved.
//

#import "TankIPhoneViewController.h"
#import "Tank.h"
#import "ModulesViewController.h"

@interface TankIPhoneViewController ()

@end

@implementation TankIPhoneViewController

@synthesize tank;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//
//    // Uncomment the following line to preserve selection between presentations.
//    // self.clearsSelectionOnViewWillAppear = NO;
// 
//    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Load the nib file
    UINib *nib = [UINib nibWithNibName:@"TankCell" bundle:nil];
    
    // Register this NIB which contains the cell
    [[self tableView] registerNib:nib
           forCellReuseIdentifier:@"Cell"];
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
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44.0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSArray *modArray = self.tank.equippedModulesNameArray;
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, width, 44)];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(10, 0, width, 42)];
    [button setTitle:modArray[section] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [[button titleLabel] setFont:[UIFont systemFontOfSize:16.0]];
    [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [button setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    
    [button addTarget:self
               action:@selector(pushModulesViewController)
     forControlEvents:UIControlEventTouchUpInside];
    
    [headerView addSubview:button];
    
    return headerView;
}

- (void)pushModulesViewController
{
    ModulesViewController *mvc = [[ModulesViewController alloc] initWithTank:tank andKey:@"availableGuns"];
    [mvc setTankIPhoneViewController:self];
    [self.navigationController pushViewController:mvc animated:YES];
}

- (void)buttonPress
{
    NSLog(@"Button Pressed");
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
