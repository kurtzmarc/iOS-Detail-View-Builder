//
//  BaseDetailViewController.m
//  HomeMaintenanceApp
//
//  Created by Marc Kurtz on 4/5/12.
//  Copyright (c) 2012 Kurtz Consulting Services LLC. All rights reserved.
//

#import "BaseDetailViewController.h"
#import "DVB_DetailView.h"

@interface BaseDetailViewController ()

@end

@implementation BaseDetailViewController

@synthesize builder = _builder;
@synthesize dataManager = _dataManager;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.builder = nil;
    self.dataManager = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_builder groupCount];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_builder groupItemCount:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  {  
    return [_builder heightForIndexPath:indexPath];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DVB_DetailViewItem* item = [_builder itemForIndexPath:indexPath];
    
    NSString *CellIdentifier = [item cellIdentifier];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [item createCell];
    }
    
    [item configureCell:cell];
    [item cellCreated:cell];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [_builder groupTitleForSection:section];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DVB_DetailViewItem* item = [_builder itemForIndexPath:indexPath];
    
    [item didSelectCell:indexPath];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    DVB_DetailViewGroup* group = [_builder groupForSection:section];
    return group.footerText;
}

@end
