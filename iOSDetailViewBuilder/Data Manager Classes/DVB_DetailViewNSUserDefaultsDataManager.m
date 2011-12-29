//
//  DVB_DetailViewNSUserDefaultsDataManager.m
//  Face Charts
//
//  Created by Marc Kurtz on 12/27/11.
//  Copyright 2011 Kurtz Consulting Services LLC. All rights reserved.
//

#import "DetailViewNSUserDefaultsDataManager.h"
#import "DetailViewBuilder.h"
#import "DetailViewItem.h"

@implementation DetailViewNSUserDefaultsDataManager

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
    return [[NSUserDefaults standardUserDefaults] valueForKeyPath:item.key];
}

-(void)setValue:(NSObject *)value forItem:(DetailViewItem*) item;
{
    [[NSUserDefaults standardUserDefaults] setValue:value forKeyPath:item.key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
