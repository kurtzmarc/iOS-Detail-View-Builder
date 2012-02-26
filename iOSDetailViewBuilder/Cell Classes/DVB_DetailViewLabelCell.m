//
//  DVB_DetailViewLabelCell.m
//  Face Charts
//
//  Created by Marc Kurtz on 2/12/12.
//  Copyright 2012 Kurtz Consulting Services LLC. All rights reserved.
//

#import "DVB_DetailViewLabelCell.h"

@implementation DVB_DetailViewLabelCell

int height;

- (NSString*)cellIdentifier
{
    return @"BuilderLabelCell";
}

- (UITableViewCell*) createCell
{
    UITableViewCell* cell;
    
    cell = [self createLabelCell];
    return cell;
}

-(CGFloat)height
{
    if (height == 0)
    {
        UILabel* label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:10.0];
        label.text = self.label;
        CGRect textSize = [label textRectForBounds:CGRectMake(0, 0, 300, CGFLOAT_MAX) limitedToNumberOfLines:0];
        height = textSize.size.height;
    }
    return height + 10;
}

- (void) configureCell:(UITableViewCell*) cell
{
    UILabel* label = (UILabel*)[cell.contentView viewWithTag:kLabelTag];
    label.text = self.label;
    CGRect textSize = [label textRectForBounds:CGRectMake(0, 0, 300, CGFLOAT_MAX) limitedToNumberOfLines:0];
    height = textSize.size.height;
    label.bounds = textSize;
}

#define GROUPED_CELL_WIDTH 300
#define CELL_PADDING 5

- (UITableViewCell*) createLabelCell {
    UITableViewCell* cell;
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:self.cellIdentifier];
    cell.clipsToBounds = YES;
    
    CGRect cellRect = cell.frame;
    CGRect labelRect = CGRectZero;
    cellRect.size.width = GROUPED_CELL_WIDTH;

    // Add label
    labelRect = CGRectMake(cell.frame.origin.x, cell.frame.origin.y, cellRect.size.width, cellRect.size.height);
    labelRect = CGRectInset(labelRect, CELL_PADDING, 0);
    UILabel* label = [[UILabel alloc] initWithFrame:labelRect];
    label.lineBreakMode = UILineBreakModeWordWrap;
    label.numberOfLines = 0;
    label.text = self.label;
    label.tag = kLabelTag;
    //label.textColor = [UIColor colorWithRed:0.32 green:0.40 blue:0.57 alpha:1.0];
    label.font = [UIFont systemFontOfSize:10.0];
    label.textAlignment = UITextAlignmentLeft;
    label.backgroundColor = [UIColor clearColor];
    label.autoresizingMask =  UIViewAutoresizingFlexibleWidth;
    CGRect textSize = [label textRectForBounds:CGRectMake(0, 0, 300, CGFLOAT_MAX) limitedToNumberOfLines:0];
    CGRect frame = label.frame;
    frame.size.height = textSize.size.height;
    label.frame = frame;
    height = textSize.size.height;
    [cell.contentView addSubview:label];
    
    return cell;
}

@end
