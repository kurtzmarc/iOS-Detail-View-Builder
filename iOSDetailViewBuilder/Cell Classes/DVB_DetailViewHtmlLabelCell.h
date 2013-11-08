//
//  Copyright 2013 Kurtz Consulting Services LLC.
//

#import "DVB_DetailViewItem.h"
#import <UIKit/UIKit.h>

@interface DVB_DetailViewHtmlLabelCell : DVB_DetailViewItem<UIWebViewDelegate>

- (UITableViewCell*) createLabelCell;

@end
