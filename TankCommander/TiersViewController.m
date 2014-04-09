//
//  TiersViewController.m
//  TankCommander
//
//  Created by Ryan Case on 11/16/13.
//  Copyright (c) 2013 Ryan Case. All rights reserved.
//

#import "TiersViewController.h"
#import "TankStore.h"
#import "TypesViewController.h"
#import "TierCell.h"
#import "Tank.h"
#import "RCFormatting.h"

@interface TiersViewController ()

@end

@implementation TiersViewController

@synthesize keys, keyStrings, allTanks, compareTank, tankViewController;

- (id)initWithStyle:(UITableViewStyle)style
{
    return [self init];
}

- (id)init
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        keys = @[@"tier1", @"tier2", @"tier3", @"tier4", @"tier5",
                 @"tier6", @"tier7", @"tier8", @"tier9", @"tier10"];
        keyStrings = @[@"Tier 1", @"Tier 2", @"Tier 3", @"Tier 4", @"Tier 5",
                       @"Tier 6", @"Tier 7", @"Tier 8", @"Tier 9", @"Tier 10"];
        allTanks = [TankStore allTanks];
        UINavigationItem *n = [self navigationItem];
        [n setTitle:NSLocalizedString(@"WOT Tank Commander", nil)];
    }
    return self;
}

// To reuse the drill down system when doing tank comparisons, the VCs have a different init
// method when being init'ed for comparing that stores a pointer to the first tank and carries
// it through all the new VCs
- (id)initForCompareWithTank:(Tank *)t
{
    self = [self init];
    if (self) {
        self.compareTank = t;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Load the nib file
    UINib *nib = [UINib nibWithNibName:@"TierCell" bundle:nil];
    
    // Register this NIB which contains the cell
    [[self tableView] registerNib:nib
           forCellReuseIdentifier:@"TierCell"];
    
    self.tableView.tableFooterView = self.footerView;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Tiers";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [keys count];
}

- (TierCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TierCell";
    TierCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    [[cell tierLabel] setText:keyStrings[indexPath.row]];
    [[cell tierRomanLabel] setText:romanStringFromInt(indexPath.row + 1)];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *tierKey = keys[indexPath.row];
    TypesViewController *tvc;
    
    // If a comparison tank is present, then init the next view controller with a pointer to the
    // comparison tank as well, this ensures that the final view controller recognizes the need
    // to push a comparison view and not just a stat view
    if (self.compareTank) {
        tvc = [[TypesViewController alloc] initForCompareWithTier:[allTanks valueForKey:tierKey]
                                                          andTank:self.compareTank];
        [tvc setTankViewController:self.tankViewController];
    } else {
        tvc = [[TypesViewController alloc] initWithTier:[allTanks valueForKey:tierKey]];
    }
    
    [self.navigationController pushViewController:tvc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}

- (UIView *)footerView
{
    RCFormatting *format = [RCFormatting store];
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, 44)];
    
    [format addButtonWithTarget:self
                       selector:@selector(presentHelpView)
                andControlEvent:UIControlEventTouchUpInside
                 withButtonData:@"howTo"
                         toView:footer
                      withFrame:CGRectMake(20, 0, 100, 24)
                           text:@"HELP"
                       fontSize:13
                      fontColor:format.darkColor
            andContentAlignment:UIControlContentVerticalAlignmentTop | UIControlContentHorizontalAlignmentLeft];
    
    return footer;
}

- (void)presentHelpView
{
    RCFormatting *format = [RCFormatting store];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        CGPoint presOrigin = [self.view.layer.presentationLayer bounds].origin;
        UIView *popup = [format fullscreenPopupForKey:@"howTo"
                               fromPresentationOrigin:presOrigin];
        [self.view addSubview:popup];
    } else {
        UIViewController *vc = [format iPhoneStatViewControllerForKey:@"howTo"];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)popToRootVC
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end










