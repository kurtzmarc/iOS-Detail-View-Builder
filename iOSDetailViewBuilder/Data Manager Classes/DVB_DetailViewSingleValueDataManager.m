//
//  DVB_DetailViewSingleValueDataManager.m
//  iOSDetailViewBuilder
//
//  Created by Marc Kurtz on 11/25/12.
//  Copyright 2012 Kurtz Consulting Services LLC. All rights reserved.
//

#import "DVB_DetailViewSingleValueDataManager.h"
#import "DVB_DetailViewBuilder.h"
#import "DVB_DetailViewItem.h"

@implementation DVB_DetailViewSingleValueDataManager

@synthesize object = _object;

- (id)initWithInitialValue:(NSObject *) object
{
    self = [super init];
    if (self) {
        self.object = object;
    }
    return self;
}


-(NSObject *)getValue:(DVB_DetailViewItem*) item;
{
    return self.object;
}

-(void)setValue:(NSObject *)value forItem:(DVB_DetailViewItem*) item;
{
    self.object = value;
}

@end
