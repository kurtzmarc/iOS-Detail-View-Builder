//
//  BaseDetailViewController.h
//  HomeMaintenanceApp
//
//  Created by Marc Kurtz on 4/5/12.
//  Copyright (c) 2012 Kurtz Consulting Services LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DVB_DetailViewBuilder, DVB_DetailViewDataManager;

@interface BaseDetailViewController : UITableViewController

@property (nonatomic, strong) DVB_DetailViewBuilder *builder;
@property (nonatomic, strong) DVB_DetailViewDataManager *dataManager;

@end
