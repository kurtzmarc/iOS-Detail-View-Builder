//
//  Copyright 2013 Kurtz Consulting Services LLC.
//

#import "DVB_DetailViewDataManager.h"
#import <CoreData/CoreData.h>

@interface DVB_DetailViewCoreDataDataManager : DVB_DetailViewDataManager

@property (nonatomic,strong) NSManagedObject* managedObject;

- (id)initWithManagedObject:(NSManagedObject *) managedObject;

@end
