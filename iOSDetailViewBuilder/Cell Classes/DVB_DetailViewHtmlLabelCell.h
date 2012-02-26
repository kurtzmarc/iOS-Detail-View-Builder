//
//  DVB_DetailViewHtmlLabelCell.h
//  Face Charts
//
//  Created by Marc Kurtz on 7/30/11.
//  Copyright 2011 Kurtz Consulting Services LLC. All rights reserved.
//

#import "DVB_DetailViewItem.h"
#import <UIKit/UIKit.h>

@interface DVB_DetailViewHtmlLabelCell : DVB_DetailViewItem<UIWebViewDelegate>

- (UITableViewCell*) createLabelCell;

@end
