//
//  DVB_DetailViewBuilder.m
//  iOSDetailViewBuilder
//
//  Created by Marc Kurtz on 12/30/11.
//  Copyright 2011 Kurtz Consulting Services LLC. All rights reserved.
//

#import "DVB_DetailViewBuilder.h"
#import "DVB_DetailViewGroup.h"
#import "DVB_DetailViewItem.h"
#import "DVB_DetailViewDataManager.h"
#import "TTGlobalUICommon.h"

@implementation DVB_DetailViewBuilder

@synthesize groupArray = _groupArray;

- (id)init
{
    self = [super init];
    if (self) {
        NSMutableArray* groupArray = [[NSMutableArray alloc] initWithObjects:nil];
        self.groupArray = groupArray;
    }
    return self;
}


-(void) addDetailViewBuilderGroup:(DVB_DetailViewGroup*) detailViewBuilderGroup;
{
    [self.groupArray addObject:detailViewBuilderGroup];
}

-(NSInteger) groupCount
{
    return [self.groupArray count];
}

-(NSInteger)groupItemCount:(NSUInteger)section
{
    DVB_DetailViewGroup* group = [self.groupArray objectAtIndex:section];
    return group == nil ? 0 : [group groupItemCount];
}

-(NSObject*) valueForIndexPath:(NSIndexPath*) index
{
    DVB_DetailViewItem* item = [self itemForIndexPath:index];
    if (item == nil)
        return nil;
    
    return [item.dataManager getValue:item];
}

-(DVB_DetailViewItem*) itemForIndexPath:(NSIndexPath*) index
{
    DVB_DetailViewGroup* group = [self.groupArray objectAtIndex:index.section];
    return group == nil ? nil : [group itemForIndex:index.row];
}

- (NSIndexPath*) indexPathForItem:(DVB_DetailViewItem*) item
{
    for (int groupIndex=0;groupIndex<self.groupArray.count;groupIndex++) {
        DVB_DetailViewGroup* group = [self.groupArray objectAtIndex:groupIndex];
        NSInteger index = [group indexOfItem:item];
        if (index != NSNotFound)
            return [NSIndexPath indexPathForRow:index inSection:groupIndex];
    }
    return nil;
}

-(NSString*) groupTitleForSection:(NSUInteger) section
{
    DVB_DetailViewGroup* group = [self.groupArray objectAtIndex:section];
    return group == nil ? @"" : group.title;
}

- (CGFloat) heightForIndexPath:(NSIndexPath *)indexPath
{
    DVB_DetailViewItem* item = [self itemForIndexPath:indexPath];
    return item == nil ? ttkDefaultRowHeight : [item height];
}

- (void) requestEndEditing
{
    for (DVB_DetailViewGroup* group in self.groupArray) {
        for (DVB_DetailViewItem* item in group.groupItemArray) {
            [item requestEndEditing];
        }
    }
}

@end
