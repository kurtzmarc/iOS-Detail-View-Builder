//
//  DVB_DetailViewDataManager.m
//  iOSDetailViewBuilder
//
//  Created by Marc Kurtz on 7/30/11.
//  Copyright 2011 Kurtz Consulting Services LLC. All rights reserved.
//

#import "DVB_DetailViewDataManager.h"
#import "DVB_DetailViewItem.h"

@implementation DVB_DetailViewDataManager

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
    @throw [NSException exceptionWithName:@"InternalCodingException" reason:@"Internal coding exception - 'value' property not implemented in class." userInfo:nil];
}

-(void)setValue:(NSObject *)value forItem:(DVB_DetailViewItem*) item;
{
    @throw [NSException exceptionWithName:@"InternalCodingException" reason:@"Internal coding exception - 'value' property not implemented in class." userInfo:nil];
}

@end
