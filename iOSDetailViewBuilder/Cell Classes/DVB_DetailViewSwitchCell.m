//
//  Copyright 2013 Kurtz Consulting Services LLC.
//

#import "DVB_DetailViewSwitchCell.h"
#import "DVB_DetailViewDataManager.h"
#import "DVB_DetailViewBuilder.h"
#import "TTGlobalUICommon.h"

@implementation DVB_DetailViewSwitchCell

@synthesize onSwitch = _onSwitch;

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

    // Create the controls
    UILabel* label = [[UILabel alloc] init];
    UISwitch* switchControl = [[UISwitch alloc] init];

    // Calculate layout
    int inset = IOS_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0") ? 15 : 10;
    CGRect labelRect;
    CGRect switchRect;
    CGRect cellRect = cell.frame;
    cellRect.size.width = GROUPED_CELL_WIDTH - inset;
    cellRect.origin.x = inset;
    CGRectDivide(cellRect, &switchRect, &labelRect, switchControl.frame.size.width, CGRectMaxXEdge);
    //labelRect = CGRectInset(labelRect, CELL_PADDING, 0);
    switchRect = CGRectInset(switchRect, CELL_PADDING, 0);

    // Add label
    label.tag = kLabelTag;
    if (IOS_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
        label.font = [UIFont systemFontOfSize:18.0];
    else
        label.font = [UIFont boldSystemFontOfSize:17.0];
    label.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    label.backgroundColor = [UIColor clearColor];
    label.frame = labelRect;
    [cell.contentView addSubview:label];
    
    // Add switch
    switchControl.frame = switchRect;
    switchControl.center = CGPointMake(switchControl.center.x, cell.center.y);
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
        self.onSwitch(switchControl.isOn);
}

- (void) configureCell:(UITableViewCell*) cell
{
    _cellHeight = 0;

    BOOL value = ((NSNumber*)[self.dataManager getValue:self]).boolValue;
    UISwitch* switchControl = (UISwitch*) [cell viewWithTag:kSwitchTag];
    [switchControl setOn:value animated:NO];

    UILabel* label = (UILabel*) [cell viewWithTag:kLabelTag];
    label.text = self.label;
    [super configureCell:cell];
}

@end
