//
//  Copyright 2013 Kurtz Consulting Services LLC.
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

-(void)dealloc
{
    _object = nil;
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
