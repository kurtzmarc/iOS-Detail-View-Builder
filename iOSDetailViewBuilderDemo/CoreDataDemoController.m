//
//  CoreDataDemoController.m
//  iOSDetailViewBuilder
//
//  Created by Marc Kurtz on 1/7/12.
//  Copyright (c) 2012 Kurtz Consulting Services LLC. All rights reserved.
//

#import "CoreDataDemoController.h"
#import "../iOSDetailViewBuilder/DVB_DetailView.h"
#import "../iOSDetailViewBuilder/DVB_DetailViewDataManagerTypes.h"
#import "../iOSDetailViewBuilder/DVB_DetailViewCellTypes.h"
#import "Person.h"

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

-(void) setPerson:(Person *)person
{
    [self.builder requestEndEditing];
    
    if (_person != nil)
    {
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }
    _person = person;
    if (self.dataManager != nil)
        ((DVB_DetailViewCoreDataDataManager*)self.dataManager).managedObject = _person;
    
    if (_person != nil)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(personUpdated:)
                                                     name:NSManagedObjectContextObjectsDidChangeNotification
                                                   object:[_person managedObjectContext]];
        // Set title...
        //self.title = _person.name;
    }
    [self.tableView reloadData];
}

- (void) personUpdated:(NSNotification*)notification {
    NSSet* deletedObjects = [[notification userInfo] objectForKey:NSDeletedObjectsKey] ;
    if ([deletedObjects containsObject:self.person])
    {
        self.person = nil;
        // Close detail view...
        //[self.navigationController popToViewController:self animated:NO];
        //[self.navigationController popViewControllerAnimated:YES];
    }
    NSSet* updatedObjects = [[notification userInfo] objectForKey:NSUpdatedObjectsKey] ;
    if ([updatedObjects containsObject:self.person])
    {
        // Set title...
        //self.title = self.person.name;
        [self.tableView reloadData];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.builder = [[DVB_DetailViewBuilder alloc] init];
    
    self.dataManager = [[DVB_DetailViewCoreDataDataManager alloc] initWithManagedObject:self.person];
    
    DVB_DetailViewGroup* group;
    DVB_DetailViewItem* item;
    
    // Group 1
    group = [[DVB_DetailViewGroup alloc] initWithTitle:@"Person" withBuilder:self.builder];
    
    item = [[DVB_DetailViewStringCell alloc] initWithLabel:@"Name" withDataManager:self.dataManager withKey:@"name" withController:self withBuilder:self.builder];
    [group addDetailViewItem:item];
    
    item = [[DVB_DetailViewDateCell alloc] initWithLabel:@"Birth Date" withDataManager:self.dataManager withKey:@"birthdate" withController:self withBuilder:self.builder];
    [group addDetailViewItem:item];
    
    item = [[DVB_DetailViewSwitchCell alloc] initWithLabel:@"Birth Date Alarm" withDataManager:self.dataManager withKey:@"birthdatealarm" withController:self withBuilder:self.builder];
    [group addDetailViewItem:item];

    group.footerText = @"Footer text can be added too!";
    
    [self.builder addDetailViewBuilderGroup:group];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.person = nil;
}

@end
