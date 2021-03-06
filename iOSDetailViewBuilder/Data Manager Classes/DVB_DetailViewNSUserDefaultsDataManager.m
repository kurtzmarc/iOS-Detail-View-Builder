//
//  Copyright 2013 Kurtz Consulting Services LLC.
//

#import "DVB_DetailViewNSUserDefaultsDataManager.h"
#import "DVB_DetailViewBuilder.h"
#import "DVB_DetailViewItem.h"
#import <UIKit/UIKit.h>

@implementation DVB_DetailViewNSUserDefaultsDataManager

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
    return [[NSUserDefaults standardUserDefaults] valueForKeyPath:item.key];
}

-(void)setValue:(NSObject *)value forItem:(DVB_DetailViewItem*) item;
{
    [[NSUserDefaults standardUserDefaults] setValue:value forKeyPath:item.key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
