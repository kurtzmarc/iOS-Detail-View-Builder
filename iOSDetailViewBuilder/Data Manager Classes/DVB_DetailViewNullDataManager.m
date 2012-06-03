//
//  DVB_DetailViewNullItem.m
//  iOSDetailViewBuilder
//
//  Created by Marc Kurtz on 7/30/11.
//  Copyright 2011 Kurtz Consulting Services LLC. All rights reserved.
//

#import "DVB_DetailViewNullDataManager.h"
#import "DVB_DetailViewItem.h"

@implementation DVB_DetailViewNullDataManager

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

-(NSObject *)getValue:(DVB_DetailViewItem*) item;
{
    if ([KEY_TRUE isEqualToString:item.key])
        return [NSNumber numberWithBool:YES];

    if ([KEY_FALSE isEqualToString:item.key])
        return [NSNumber numberWithBool:NO];

    return nil;
}

-(void)setValue:(NSObject *)value forItem:(DVB_DetailViewItem*) item;
{
    // Do nothing...
}

@end
