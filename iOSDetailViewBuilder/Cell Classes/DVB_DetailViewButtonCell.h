//
//  DVB_DetailViewButtonCell.h
//  Face Charts
//
//  Created by Marc Kurtz on 7/30/11.
//  Copyright 2011 Kurtz Consulting Services LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DVB_DetailViewItem.h"

@class DVB_DetailViewDataManager, DVB_DetailViewDataManager;

typedef void(^BlockAction)(void);

@interface DVB_DetailViewButtonCell : DVB_DetailViewItem

- (id)initWithLabel:(NSString *) labelString
    withDataManager:(DVB_DetailViewDataManager*) dataManager
            withKey:(NSString*) key
     withController:(UITableViewController*) controller
        withBuilder:(DVB_DetailViewDataManager*) builder;

@property (nonatomic,strong) BlockAction onClick;

@end
