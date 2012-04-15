//
//  DVB_DetailViewGroup.m
//  iOSDetailViewBuilder
//
//  Created by Marc Kurtz on 6/26/11.
//  Copyright 2011 Kurtz Consulting Services LLC. All rights reserved.
//

#import "DVB_DetailViewGroup.h"
#import "DVB_DetailViewItem.h"

@implementation DVB_DetailViewGroup

@synthesize title = _title;
@synthesize builder = _builder;
@synthesize groupItemArray = _groupItemArray;

- (id)initWithTitle:(NSString *) title withBuilder:(DVB_DetailViewBuilder*) builder {
    self = [super init];
    if (self) {
        NSMutableArray* groupItemArray = [[NSMutableArray alloc] init];
        self.groupItemArray = groupItemArray;
        
        self.title = title;
        self.builder = builder;
    }
    return self;
}

-(void) addDetailViewItem:(DVB_DetailViewItem*) detailViewItem
{
    [self.groupItemArray addObject:detailViewItem];
}

-(NSInteger) groupItemCount
{
    return [self.groupItemArray count];
}

- (DVB_DetailViewItem*) itemForIndex:(NSInteger) index
{
    return [self.groupItemArray objectAtIndex:index];
}

- (NSInteger) indexOfItem:(DVB_DetailViewItem*) item
{
    return [self.groupItemArray indexOfObject:item];
}

@end
