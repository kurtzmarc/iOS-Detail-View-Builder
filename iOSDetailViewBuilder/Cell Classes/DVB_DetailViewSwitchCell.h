//
//  DVB_DetailViewTextCell.h
//  iOSDetailViewBuilder
//
//  Created by Marc Kurtz on 7/30/11.
//  Copyright 2011 Kurtz Consulting Services LLC. All rights reserved.
//

#import "DVB_DetailViewItem.h"
#import <UIKit/UIKit.h>

@class DVB_DetailViewDataManager, DVB_DetailViewBuilder;

@interface DVB_DetailViewSwitchCell : DVB_DetailViewItem
{
    int _cellHeight;
    int _cellWidth;
}

- (id)initWithLabel:(NSString *) labelString
    withDataManager:(DVB_DetailViewDataManager*) dataManager
            withKey:(NSString*) key
     withController:(UITableViewController*) controller
        withBuilder:(DVB_DetailViewBuilder*) builder;

- (void) onSwitch:(id) sender;

@property (nonatomic, copy) void(^onSwitch)(BOOL);

@end
