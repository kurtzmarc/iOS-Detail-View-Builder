//
//  NSUserDefaultsDemoController.m
//  iOSDetailViewBuilderDemo
//
//  Created by Marc Kurtz on 1/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NSUserDefaultsDemoController.h"
#import "../iOSDetailViewBuilder/DVB_DetailView.h"
#import "../iOSDetailViewBuilder/DVB_DetailViewDataManagerTypes.h"
#import "../iOSDetailViewBuilder/DVB_DetailViewCellTypes.h"

@interface NSUserDefaultsDemoController () {
@private
    DVB_DetailViewBuilder* _builder;
    DVB_DetailViewDataManager* _dataManager;
}

@end

@implementation NSUserDefaultsDemoController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(defaultsChanged:)  
                                                 name:NSUserDefaultsDidChangeNotification
                                               object:nil];
    
    _builder = [[DVB_DetailViewBuilder alloc] init];
    
    _dataManager = [[DVB_DetailViewNSUserDefaultsDataManager alloc] init];
    
    DVB_DetailViewGroup* group;
    DVB_DetailViewItem* item;
    
    // Group 1
    group = [[DVB_DetailViewGroup alloc] initWithTitle:@"Group 1" withBuilder:_builder];
    
    item = [[DVB_DetailViewStringCell alloc] initWithLabel:@"String Cell" withDataManager:_dataManager withKey:@"StringCell" withController:self withBuilder:_builder];
    [group addDetailViewItem:item];
    
    item = [[DVB_DetailViewDateCell alloc] initWithLabel:@"Date Cell" withDataManager:_dataManager withKey:@"DateCell" withController:self withBuilder:_builder];
    [group addDetailViewItem:item];
    
    item = [[DVB_DetailViewSwitchCell alloc] initWithLabel:@"Switch Cell" withDataManager:_dataManager withKey:@"SwitchCell" withController:self withBuilder:_builder];
    [group addDetailViewItem:item];
    
    item = [[DVB_DetailViewButtonCell alloc] initWithLabel:@"Button Cell" withDataManager:_dataManager withKey:@"" withController:self withBuilder:_builder];
    [group addDetailViewItem:item];
    
    [_builder addDetailViewBuilderGroup:group];
    
    // Group 2
    group = [[DVB_DetailViewGroup alloc] initWithTitle:@"Group 2" withBuilder:_builder];
    
    item = [[DVB_DetailViewStringCell alloc] initWithLabel:@"String Cell 2" withDataManager:_dataManager withKey:@"StringCell2" withController:self withBuilder:_builder];
    [group addDetailViewItem:item];
    
    item = [[DVB_DetailViewDateCell alloc] initWithLabel:@"Date Cell 2" withDataManager:_dataManager withKey:@"DateCell2" withController:self withBuilder:_builder];
    [group addDetailViewItem:item];
    
    item = [[DVB_DetailViewSwitchCell alloc] initWithLabel:@"Switch Cell 2" withDataManager:_dataManager withKey:@"SwitchCell2" withController:self withBuilder:_builder];
    [group addDetailViewItem:item];
    
    item = [[DVB_DetailViewButtonCell alloc] initWithLabel:@"Button Cell 2" withDataManager:_dataManager withKey:@"" withController:self withBuilder:_builder];
    [group addDetailViewItem:item];
    
    [_builder addDetailViewBuilderGroup:group];
}

- (void)defaultsChanged:(NSNotification *)notification {
    [self.tableView reloadData];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;

    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
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
    return [_builder heightForIndexPath:indexPath ];
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

@end
