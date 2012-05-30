//
//  DVB_DetailViewLabelCell.m
//  iOSDetailViewBuilder
//
//  Created by Marc Kurtz on 2/12/12.
//  Copyright 2012 Kurtz Consulting Services LLC. All rights reserved.
//

#import "DVB_DetailViewLabelCell.h"
#import <QuartzCore/QuartzCore.h>

#define GROUPED_CELL_WIDTH 320
#define CELL_PADDING 5

@implementation DVB_DetailViewLabelCell

@synthesize font = _font;

- (id)initWithLabel:(NSString*) labelString
    withDataManager:(DVB_DetailViewDataManager*) dataManager
            withKey:(NSString*) key
     withController:(UITableViewController*) controller
        withBuilder:(DVB_DetailViewBuilder*) builder
{
    self = [super initWithLabel:labelString withDataManager:dataManager withKey:key withController:controller withBuilder:builder];
    if (self) {
        _font = [UIFont systemFontOfSize:12];
    }
    return self;
}

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
    CGSize textSize = [self.label sizeWithFont:self.font constrainedToSize:CGSizeMake(self.tableViewController.tableView.frame.size.width - (CELL_PADDING * 2), CGFLOAT_MAX) lineBreakMode:UILineBreakModeWordWrap];
    return textSize.height + 10;
}

- (void) configureCell:(UITableViewCell*) cell
{
    UILabel* label = (UILabel*)[cell.contentView viewWithTag:kLabelTag];
    label.font = self.font;
    label.text = self.label;
}

- (UITableViewCell*) createLabelCell {
    UITableViewCell* cell;
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:self.cellIdentifier];
    cell.clipsToBounds = YES;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.userInteractionEnabled = NO;
    
    // Add label
    CGRect labelRect = CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height);
    labelRect = CGRectInset(labelRect, CELL_PADDING, CELL_PADDING);
    UILabel* label = [[UILabel alloc] initWithFrame:labelRect];
    label.lineBreakMode = UILineBreakModeWordWrap;
    label.numberOfLines = 0;
    label.text = self.label;
    label.tag = kLabelTag;
    //label.textColor = [UIColor colorWithRed:0.32 green:0.40 blue:0.57 alpha:1.0];
    label.font = self.font;
    label.textAlignment = UITextAlignmentLeft;
    label.backgroundColor = [UIColor clearColor];
    label.autoresizingMask =  UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [cell.contentView addSubview:label];
    return cell;
}

@end
