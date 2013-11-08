//
//  Copyright 2013 Kurtz Consulting Services LLC.
//

#import "DVB_DetailViewItem.h"

@interface DVB_DetailViewLabelCell : DVB_DetailViewItem

- (UITableViewCell*) createLabelCell;

@property (strong, nonatomic) UIFont* font;
@property (assign, nonatomic) CGSize textInset;

@end
