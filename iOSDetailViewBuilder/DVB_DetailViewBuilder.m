//
//  Copyright 2013 Kurtz Consulting Services LLC.
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

-(void)dealloc
{
    //
}

-(void) addDetailViewBuilderGroup:(DVB_DetailViewGroup*) detailViewBuilderGroup;
{
    [self.groupArray addObject:detailViewBuilderGroup];
}

- (void) removeDetailViewItemAtIndexPath:(NSIndexPath*) index
{
    DVB_DetailViewGroup* group = [self groupForSection:index.section];
    if (group)
        [group removeDetailViewItemAtIndex:index.row];
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

- (NSUInteger) indexForGroup:(DVB_DetailViewGroup*)group
{
    return [self.groupArray indexOfObject:group];
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
    DVB_DetailViewGroup* group = [self groupForSection:index.section];
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

- (DVB_DetailViewGroup*) groupForSection:(NSInteger) section
{
   return [self.groupArray objectAtIndex:section];
}

- (NSString*) groupTitleForSection:(NSUInteger) section
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

- (void) updateEditors
{
    for (DVB_DetailViewGroup* group in self.groupArray) {
        for (DVB_DetailViewItem* item in group.groupItemArray) {
            UITableViewCell* cell = [item.tableViewController.tableView cellForRowAtIndexPath:[self indexPathForItem:item]];
            if (cell)
                [item configureCell:cell];
        }
    }
}

@end
