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
#import "TTGlobalUICommon.h"

@implementation DVB_DetailViewSwitchCell

@synthesize onSwitch = _onSwitch;

#define GROUPED_CELL_WIDTH 300
#define CELL_PADDING 5

- (id)initWithLabel:(NSString *) labelString
    withDataManager:(DVB_DetailViewDataManager*) dataManager
            withKey:(NSString*) key
     withController:(UITableViewController*) controller
        withBuilder:(DVB_DetailViewBuilder*) builder
{
    self = [super initWithLabel:labelString withDataManager:dataManager withKey:key withController:controller withBuilder:builder];
    if (self) {
        _cellHeight = 0;
        //if (NIInterfaceOrientation() == UIInterfaceOrientationLandscapeLeft || NIInterfaceOrientation() == UIInterfaceOrientationLandscapeRight)        
        if (TTDeviceOrientationIsLandscape())
            _cellWidth = TTIsPad() ? 515 : 340;
        else if (TTDeviceOrientationIsPortrait())
            _cellWidth = TTIsPad() ? 576 : 180;
    }
    return self;
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
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(20, 12, 0, cell.frame.size.height)];
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
    if (self.onSwitch)
        self.onSwitch();
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
