//
//  DVB_DetailViewImageButtonCell.h
//  Face Charts
//
//  Created by Marc Kurtz on 2/12/12.
//  Copyright 2012 Kurtz Consulting Services LLC. All rights reserved.
//

#import "DVB_DetailViewButtonCell.h"

@interface DVB_DetailViewImageButtonCell : DVB_DetailViewButtonCell

- (UITableViewCell*) createImageButtonCell;

@property (nonatomic, strong) UIImage* image;

@end
