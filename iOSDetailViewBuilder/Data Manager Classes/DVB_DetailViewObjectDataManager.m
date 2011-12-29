//
//  DVB_DetailViewObjectItem.m
//  Face Charts
//
//  Created by Marc Kurtz on 7/30/11.
//  Copyright 2011 Kurtz Consulting Services LLC. All rights reserved.
//

#import "DetailViewObjectDataManager.h"
#import "DetailViewBuilder.h"
#import "DetailViewItem.h"

@implementation DetailViewObjectDataManager

@synthesize object = _object;

- (id)initWithObject:(NSObject *) object
{
    self = [super init];
    if (self) {
        self.object = object;
    }
    return self;
}


-(NSObject *)getValue:(DetailViewItem*) item;
{
    return self.object ? [self.object valueForKey:item.key] : nil;
}

-(void)setValue:(NSObject *)value forItem:(DetailViewItem*) item;
{
    if (self.object)
        [self.object setValue:value forKey:item.key];
}

@end
