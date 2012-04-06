//
//  DVB_DetailViewImageButtonCell.m
//  Face Charts
//
//  Created by Marc Kurtz on 2/12/12.
//  Copyright 2012 Kurtz Consulting Services LLC. All rights reserved.
//

#import "DVB_DetailViewImageButtonCell.h"

@implementation DVB_DetailViewImageButtonCell

@synthesize image = _image;

- (NSString*)cellIdentifier
{
    return @"BuilderImageButtonCell";
}

- (UITableViewCell*) createCell
{
    UITableViewCell* cell;
    
    cell = [self createImageButtonCell];
    return cell;
}

- (void) configureCell:(UITableViewCell*) cell
{
    UILabel* label = (UILabel*)[cell.contentView viewWithTag:kLabelTag];
    UIImageView* imageView = (UIImageView*)[cell.contentView viewWithTag:kImageViewTag];
    label.text = self.label;
    imageView.image = self.image;
}

#define GROUPED_CELL_WIDTH 300
#define CELL_PADDING 5

- (UITableViewCell*) createImageButtonCell {
    UITableViewCell* cell;
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:self.cellIdentifier];
    cell.clipsToBounds = YES;
    
    // Calculate layout
    CGRect cellRect = cell.frame;
    CGRect labelRect = CGRectZero, imageRect = CGRectZero;
    //cellRect.size.width = GROUPED_CELL_WIDTH;
    
    // Add label
    labelRect = CGRectMake(cellRect.origin.x, cellRect.origin.y, cellRect.size.width, cellRect.size.height);
    labelRect = CGRectInset(labelRect, CELL_PADDING, 0);
    UILabel* label = [[UILabel alloc] initWithFrame:labelRect];
    label.text = self.label;
    label.tag = kLabelTag;
    //label.textColor = [UIColor colorWithRed:0.32 green:0.40 blue:0.57 alpha:1.0];
    label.font = [UIFont boldSystemFontOfSize:17.0];
    label.textAlignment = UITextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    label.autoresizingMask =  UIViewAutoresizingFlexibleWidth;
    [cell.contentView addSubview:label];
    
    // Add image view
    imageRect = CGRectMake(cellRect.origin.x, cellRect.origin.y, 40, cellRect.size.height);
    imageRect = CGRectInset(imageRect, CELL_PADDING, 8);
    UIImageView* imageView = [[UIImageView alloc] initWithFrame:imageRect];
    //textField.backgroundColor = [UIColor clearColor];
    //textField.scrollEnabled = NO;
    //textField.userInteractionEnabled = NO;
    //textField.delegate = delegate;
    imageView.tag = kImageViewTag;
    //textField.returnKeyType = UIReturnKeyDone;
    imageView.autoresizingMask =  UIViewAutoresizingNone;// | UIViewAutoresizingFlexibleHeight ;
    //textField.enablesReturnKeyAutomatically = YES;
    //[textField.layer setBorderWidth:1.0];
    [cell.contentView addSubview:imageView];
    
    return cell;
}

@end