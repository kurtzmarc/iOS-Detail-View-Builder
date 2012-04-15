//
//  DVB_DetailViewObjectItem.m
//  iOSDetailViewBuilder
//
//  Created by Marc Kurtz on 7/30/11.
//  Copyright 2011 Kurtz Consulting Services LLC. All rights reserved.
//

#import "DVB_DetailViewObjectDataManager.h"
#import "DVB_DetailViewBuilder.h"
#import "DVB_DetailViewItem.h"

@implementation DVB_DetailViewObjectDataManager

@synthesize object = _object;

- (id)initWithObject:(NSObject *) object
{
    self = [super init];
    if (self) {
        self.object = object;
    }
    return self;
}


-(NSObject *)getValue:(DVB_DetailViewItem*) item;
{
    return self.object ? [self.object valueForKey:item.key] : nil;
}

-(void)setValue:(NSObject *)value forItem:(DVB_DetailViewItem*) item;
{
    if (self.object)
        [self.object setValue:value forKey:item.key];
}

@end
