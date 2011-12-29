//
//  DVB_DetailViewCoreDataItem.m
//  Face Charts
//
//  Created by Marc Kurtz on 7/30/11.
//  Copyright 2011 Kurtz Consulting Services LLC. All rights reserved.
//

#import "DetailViewCoreDataDataManager.h"
#import "DetailViewBuilder.h"
#import "DetailViewItem.h"

@implementation DetailViewCoreDataDataManager

@synthesize managedObject = _managedObject;

- (id)initWithManagedObject:(NSManagedObject *) managedObject
{
    self = [super init];
    if (self) {
        self.managedObject = managedObject;
    }
    return self;
}


-(NSObject *)getValue:(DetailViewItem*) item;
{
    return self.managedObject ? [self.managedObject valueForKeyPath:item.key] : nil;
}

-(void)setValue:(NSObject *)value forItem:(DetailViewItem*) item;
{
    if (self.managedObject)
    {
        [self.managedObject setValue:value forKey:item.key];
        
        NSError *error;
        if (![self.managedObject.managedObjectContext save:&error])
            NSLog(@"Error saving: %@", [error localizedDescription]);
    }
}

@end
