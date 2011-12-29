//
//  DVB_DetailViewCoreDataItem.h
//  Face Charts
//
//  Created by Marc Kurtz on 7/30/11.
//  Copyright 2011 Kurtz Consulting Services LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DetailViewDataManager.h"

@interface DetailViewCoreDataDataManager : DetailViewDataManager

@property (nonatomic,strong) NSManagedObject* managedObject;

- (id)initWithManagedObject:(NSManagedObject *) managedObject;

@end
