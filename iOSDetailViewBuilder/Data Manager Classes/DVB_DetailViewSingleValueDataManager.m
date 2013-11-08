//
//  Copyright 2013 Kurtz Consulting Services LLC.
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
