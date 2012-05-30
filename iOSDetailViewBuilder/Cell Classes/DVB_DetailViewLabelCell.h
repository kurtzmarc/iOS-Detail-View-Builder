//
//  DVB_DetailViewLabelCell.h
//  iOSDetailViewBuilder
//
//  Created by Marc Kurtz on 7/30/11.
//  Copyright 2011 Kurtz Consulting Services LLC. All rights reserved.
//

#import "DVB_DetailViewItem.h"

@interface DVB_DetailViewLabelCell : DVB_DetailViewItem

- (UITableViewCell*) createLabelCell;

@property (assign, nonatomic) int fontSize;

@end
