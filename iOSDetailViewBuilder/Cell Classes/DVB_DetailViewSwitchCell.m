//
//  DVB_DetailViewTextCell.m
//  Face Charts
//
//  Created by Marc Kurtz on 12/30/11.
//  Copyright 2011 Kurtz Consulting Services LLC. All rights reserved.
//

#import "DVB_DetailViewSwitchCell.h"
#import "DVB_DetailViewDataManager.h"
#import "DVB_DetailViewBuilder.h"

@implementation DetailViewSwitchCell

#define GROUPED_CELL_WIDTH 300
#define CELL_PADDING 5

- (id)initWithLabel:(NSString *) labelString
    withDataManager:(DetailViewDataManager*) dataManager
            withKey:(NSString*) key
     withController:(UITableViewController*) controller
        withBuilder:(DetailViewBuilder*) builder
{
    self = [super initWithLabel:labelString withDataManager:dataManager withKey:key withController:controller withBuilder:builder];
    if (self) {
        _cellHeight = 0;
        if (TTDeviceOrientationIsLandscape())
            _cellWidth = TTIsPad() ? 515 : 340;
        else if (TTDeviceOrientationIsPortrait())
            _cellWidth = TTIsPad() ? 576 : 180;
    }
    return self;
}

-(CGFloat)height
{
    if (_cellHeight == 0)
    {
        NSString* value = (NSString*)[self.dataManager getValue:self];

        UITextView* textView = [[UITextView alloc]initWithFrame:CGRectMake(0,0,_cellWidth,0)];
        textView.text = value.length > 0 ? value : @" ";
        textView.font = [UIFont boldSystemFontOfSize:15];
        [textView sizeToFit];
        _cellHeight = MAX(textView.contentSize.height, ttkDefaultRowHeight);
    }
    return _cellHeight;
}

- (NSString*)cellIdentifier
{
    return [@"BuilderSwitchCell-" stringByAppendingString:self.key];
}

- (UITableViewCell*) createCell
{
    UITableViewCell* cell;
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:self.cellIdentifier];
    cell.clipsToBounds = YES;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    // Add label
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(20, 12, 0, cell.height)];
    label.tag = kLabelTag;
    label.font = [UIFont boldSystemFontOfSize:17.0];
    label.backgroundColor = [UIColor clearColor];
    [cell.contentView addSubview:label];
    
    // Add switch
    //UISwitch* switchControl = [[UISwitch alloc] initWithFrame:switchRect];
    UISwitch* switchControl = [[UISwitch alloc] init];
    CGRect frame = switchControl.frame;
    frame = CGRectOffset(frame, cell.contentView.frame.size.width - frame.size.width - CELL_PADDING, (cell.contentView.frame.size.height-frame.size.height)/2);
    switchControl.frame = frame;
    switchControl.backgroundColor = [UIColor clearColor];
    switchControl.tag = kSwitchTag;
    [switchControl addTarget: self action: @selector(onSwitch:) forControlEvents:UIControlEventValueChanged];
    switchControl.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    [cell.contentView addSubview:switchControl];
    
    return cell;
}

- (void) onSwitch:(id) sender
{
    UISwitch* switchControl = (UISwitch*) sender;
    [self.dataManager setValue:[NSNumber numberWithBool:switchControl.isOn] forItem:self];
}

- (void) configureCell:(UITableViewCell*) cell
{
    _cellHeight = 0;

    BOOL value = ((NSNumber*)[self.dataManager getValue:self]).boolValue;
    UISwitch* switchControl = (UISwitch*) [cell viewWithTag:kSwitchTag];
    [switchControl setOn:value animated:NO];

    UILabel* label = (UILabel*) [cell viewWithTag:kLabelTag];
    label.text = self.label;
    [label sizeToFit];
}

-(void)didSelectCell:(NSIndexPath *)indexPath
{
    // Do nothing...
}

@end
