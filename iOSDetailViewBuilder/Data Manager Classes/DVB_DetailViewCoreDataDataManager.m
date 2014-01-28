//
//  Copyright 2013 Kurtz Consulting Services LLC.
//

#import "DVB_DetailViewCoreDataDataManager.h"
#import "DVB_DetailViewBuilder.h"
#import "DVB_DetailViewItem.h"
//#import "TTGlobalUICommon.h"

@implementation DVB_DetailViewCoreDataDataManager

@synthesize managedObject = _managedObject;

- (id)initWithManagedObject:(NSManagedObject *) managedObject
{
    self = [super init];
    if (self) {
        self.managedObject = managedObject;
    }
    return self;
}

-(void)dealloc
{
    _managedObject = nil;
}

-(NSObject *)getValue:(DVB_DetailViewItem*) item;
{
    return self.managedObject ? [self.managedObject valueForKeyPath:item.key] : nil;
}

-(void)setValue:(NSObject *)value forItem:(DVB_DetailViewItem*) item;
{
    if (self.managedObject && (!self.managedObject.isDeleted))
    {
//        if (TTOSVersion() >= 5.0) {
//            NSManagedObjectContext* moc = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
//            [moc setPersistentStoreCoordinator:self.managedObject.managedObjectContext.persistentStoreCoordinator];
//            NSManagedObjectID* objectId = self.managedObject.objectID;
//            [moc performBlock:^{
//                NSManagedObject* managedObject = [moc objectWithID:objectId];
//                
//                [managedObject setValue:value forKey:item.key];
//                
//                NSError *error;
//                if (![moc save:&error])
//                    NSLog(@"Error saving: %@", [error localizedDescription]);
//            }];
//        } else {
        [self.managedObject setValue:value forKey:item.key];
        
        NSError *error;
        if (![self.managedObject.managedObjectContext save:&error])
            NSLog(@"Error saving: %@", [error localizedDescription]);
//        }
    }
}

@end
