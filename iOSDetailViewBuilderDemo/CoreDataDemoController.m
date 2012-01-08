//
//  CoreDataDemoController.m
//  iOSDetailViewBuilder
//
//  Created by Marc Kurtz on 1/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CoreDataDemoController.h"
#import "../iOSDetailViewBuilder/DVB_DetailView.h"
#import "../iOSDetailViewBuilder/DVB_DetailViewDataManagerTypes.h"
#import "../iOSDetailViewBuilder/DVB_DetailViewCellTypes.h"
#import "Person.h"

@interface CoreDataDemoController (){
@private
    DVB_DetailViewBuilder* _builder;
    DVB_DetailViewDataManager* _dataManager;
}

@end

@implementation CoreDataDemoController

@synthesize person = _person;

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

    _builder = [[DVB_DetailViewBuilder alloc] init];
    
    _dataManager = [[DVB_DetailViewCoreDataDataManager alloc] initWithManagedObject:self.person];
    
    DVB_DetailViewGroup* group;
    DVB_DetailViewItem* item;
    
    // Group 1
    group = [[DVB_DetailViewGroup alloc] initWithTitle:@"Person" withBuilder:_builder];
    
    item = [[DVB_DetailViewStringCell alloc] initWithLabel:@"Name" withDataManager:_dataManager withKey:@"name" withController:self withBuilder:_builder];
    [group addDetailViewItem:item];
    
    item = [[DVB_DetailViewDateCell alloc] initWithLabel:@"Birth Date" withDataManager:_dataManager withKey:@"birthdate" withController:self withBuilder:_builder];
    [group addDetailViewItem:item];
    
    item = [[DVB_DetailViewSwitchCell alloc] initWithLabel:@"Birth Date Alarm" withDataManager:_dataManager withKey:@"birthdatealarm" withController:self withBuilder:_builder];
    [group addDetailViewItem:item];
    
    [_builder addDetailViewBuilderGroup:group];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
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
