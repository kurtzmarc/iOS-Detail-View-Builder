//
//  Copyright 2013 Kurtz Consulting Services LLC.
//

#import "DVB_DetailViewGroup.h"
#import "DVB_DetailViewItem.h"

@implementation DVB_DetailViewGroup

@synthesize title = _title;
@synthesize footerText = _footerText;
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

-(void)dealloc
{
    //
}

-(void) addDetailViewItem:(DVB_DetailViewItem*) detailViewItem
{
    [self.groupItemArray addObject:detailViewItem];
}

- (void) removeDetailViewItemAtIndex:(NSInteger) index;
{
    [self.groupItemArray removeObjectAtIndex:index];
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
