//
//  DVB_DetailViewNullItem.m
//  Face Charts
//
//  Created by Marc Kurtz on 7/30/11.
//  Copyright 2011 Kurtz Consulting Services LLC. All rights reserved.
//

#import "DetailViewNullDataManager.h"

@implementation DetailViewNullDataManager

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

-(NSObject *)getValue:(DetailViewItem*) item;
{
    return nil;
}

-(void)setValue:(NSObject *)value forItem:(DetailViewItem*) item;
{
    // Do nothing...
}

@end
