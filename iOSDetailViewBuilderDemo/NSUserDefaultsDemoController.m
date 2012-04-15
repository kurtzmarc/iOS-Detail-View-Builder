//
//  NSUserDefaultsDemoController.m
//  iOSDetailViewBuilderDemo
//
//  Created by Marc Kurtz on 1/7/12.
//  Copyright (c) 2012 Kurtz Consulting Services LLC. All rights reserved.
//

#import "NSUserDefaultsDemoController.h"
#import "../iOSDetailViewBuilder/DVB_DetailView.h"
#import "../iOSDetailViewBuilder/DVB_DetailViewDataManagerTypes.h"
#import "../iOSDetailViewBuilder/DVB_DetailViewCellTypes.h"

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
    
    self.builder = [[DVB_DetailViewBuilder alloc] init];
    
    self.dataManager = [[DVB_DetailViewNSUserDefaultsDataManager alloc] init];
    
    DVB_DetailViewGroup* group;
    DVB_DetailViewItem* item;
    
    // Group 1
    group = [[DVB_DetailViewGroup alloc] initWithTitle:@"Group 1" withBuilder:self.builder];
    
    item = [[DVB_DetailViewStringCell alloc] initWithLabel:@"String Cell" withDataManager:self.dataManager withKey:@"StringCell" withController:self withBuilder:self.builder];
    [group addDetailViewItem:item];
    
    item = [[DVB_DetailViewDateCell alloc] initWithLabel:@"Date Cell" withDataManager:self.dataManager withKey:@"DateCell" withController:self withBuilder:self.builder];
    [group addDetailViewItem:item];
    
    item = [[DVB_DetailViewSwitchCell alloc] initWithLabel:@"Switch Cell" withDataManager:self.dataManager withKey:@"SwitchCell" withController:self withBuilder:self.builder];
    [group addDetailViewItem:item];
    
    item = [[DVB_DetailViewButtonCell alloc] initWithLabel:@"Button Cell" withDataManager:self.dataManager withKey:@"" withController:self withBuilder:self.builder];
    [group addDetailViewItem:item];
    
    [self.builder addDetailViewBuilderGroup:group];
    
    // Group 2
    group = [[DVB_DetailViewGroup alloc] initWithTitle:@"Group 2" withBuilder:self.builder];
    
    item = [[DVB_DetailViewStringCell alloc] initWithLabel:@"String Cell 2" withDataManager:self.dataManager withKey:@"StringCell2" withController:self withBuilder:self.builder];
    [group addDetailViewItem:item];
    
    item = [[DVB_DetailViewDateCell alloc] initWithLabel:@"Date Cell 2" withDataManager:self.dataManager withKey:@"DateCell2" withController:self withBuilder:self.builder];
    [group addDetailViewItem:item];
    
    item = [[DVB_DetailViewSwitchCell alloc] initWithLabel:@"Switch Cell 2" withDataManager:self.dataManager withKey:@"SwitchCell2" withController:self withBuilder:self.builder];
    [group addDetailViewItem:item];
    
    item = [[DVB_DetailViewButtonCell alloc] initWithLabel:@"Button Cell 2" withDataManager:self.dataManager withKey:@"" withController:self withBuilder:self.builder];
    [group addDetailViewItem:item];
    
    [self.builder addDetailViewBuilderGroup:group];
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

@end
