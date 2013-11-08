//
//  Copyright 2013 Kurtz Consulting Services LLC.
//

#import <UIKit/UIKit.h>

@class DVB_DetailViewBuilder, DVB_DetailViewDataManager;

@interface BaseDetailViewController : UITableViewController

@property (nonatomic, strong) DVB_DetailViewBuilder *builder;
@property (nonatomic, strong) DVB_DetailViewDataManager *dataManager;

@end
