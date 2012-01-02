//
//  DVB_DetailViewCoreDataItem.h
//  Face Charts
//
//  Created by Marc Kurtz on 7/30/11.
//  Copyright 2011 Kurtz Consulting Services LLC. All rights reserved.
//

#import "DVB_DetailViewDataManager.h"
#import <CoreData/CoreData.h>

@interface DVB_DetailViewCoreDataDataManager : DVB_DetailViewDataManager

@property (nonatomic,strong) NSManagedObject* managedObject;

- (id)initWithManagedObject:(NSManagedObject *) managedObject;

@end
