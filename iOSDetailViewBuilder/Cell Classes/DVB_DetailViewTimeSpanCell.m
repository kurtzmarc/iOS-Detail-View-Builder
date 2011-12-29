//
//  DVB_DetailViewDateCell.m
//  Face Charts
//
//  Created by Marc Kurtz on 7/30/11.
//  Copyright 2011 Kurtz Consulting Services LLC. All rights reserved.
//

#import "DetailViewTimeSpanCell.h"
#import "DetailViewDataManager.h"
#import "DetailViewBuilder.h"
#import "Constants.h"
#import "Three20/Three20+Additions.h"

@implementation DetailViewTimeSpanCell
{
    @private
    int _value1;
    int _value2;
}
@synthesize popoverController = _popoverController;
@synthesize actionSheet = _actionSheet;
@synthesize picker = _picker;

- (id)initWithLabel:(NSString *) labelString
    withDataManager:(DetailViewDataManager*) dataManager
            withKey:(NSString*) key
     withController:(UITableViewController*) controller
        withBuilder:(DetailViewBuilder*) builder
{
    self = [super initWithLabel:labelString withDataManager:dataManager withKey:key withController:controller withBuilder:builder];
    if (self) {
        _contentOffsetY = 0;
    }
    return self;
}

- (NSString*)cellIdentifier
{
    return [@"BuilderTimeSpanCell-" stringByAppendingString:self.key];
}

- (UITableViewCell*) createCell
{
    UITableViewCell* cell = [self createStockCellWithDelegate:nil isEditable:NO];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void) configureCell:(UITableViewCell*) cell
{
    NSNumber* value1 = [[NSUserDefaults standardUserDefaults] valueForKey:USERDEFAULT_NEW_EVENT_SCHEDULE_TIME_SPAN_VALUE1];
    NSNumber* value2 = [[NSUserDefaults standardUserDefaults] valueForKey:USERDEFAULT_NEW_EVENT_SCHEDULE_TIME_SPAN_VALUE2];
    _value1 = [value1 intValue];
    _value2 = [value2 intValue];
    UITextView* textView = (UITextView*) [cell viewWithTag:kTextFieldTag];
    CGRect frame = textView.frame;
    frame.origin.y = 5;
    textView.frame = frame;
    textView.text = [DetailViewTimeSpanCell titleForPickerValue1:_value1 withValue2:_value2];
    UILabel* label = (UILabel*) [cell viewWithTag:kLabelTag];
    label.text = self.label;
}

- (void) didSelectCell:(NSIndexPath*)indexPath
{
    [self.tableViewController.view endEditing:YES];
    
    UIPickerView* datePicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 44, 320, 216)];
    self.picker = datePicker;
    datePicker.delegate = self;
    datePicker.dataSource = self;
    [datePicker selectRow:_value1 inComponent:0 animated:NO];
    [datePicker selectRow:_value2 inComponent:1 animated:NO];
    /*NSObject* obj = [self.dataManager getValue:self];

    if (obj)
        datePicker.date = (NSDate*)obj;
    else
        datePicker.date = [NSDate dateWithToday];*/
    
    UIToolbar* pickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    pickerToolbar.barStyle=UIBarStyleBlackOpaque;
    
    NSMutableArray *barItems = [[NSMutableArray alloc] init];   
    UIBarButtonItem *cancelBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(timeSpanPickerCancelClick)];
    [barItems addObject:cancelBtn];
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc]
                                  initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                  target:nil
                                  action:nil];
    [barItems addObject:flexSpace];
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(timeSpanPickerDoneClick)];
    [barItems addObject:doneBtn];
    
    [pickerToolbar setItems:barItems animated:YES];
    
    if (TTIsPad())
    {
        UIViewController* viewController = [[UIViewController alloc] init];
        [viewController.view addSubview:pickerToolbar];
        [viewController.view addSubview:datePicker];
        
        UIPopoverController* popoverController = [[UIPopoverController alloc] initWithContentViewController:viewController];
        self.popoverController = popoverController;
        popoverController.popoverContentSize = CGSizeMake(320, 260);
        popoverController.delegate = self;
        [popoverController presentPopoverFromRect:[self.tableViewController.tableView rectForRowAtIndexPath:indexPath]
                                           inView:self.tableViewController.view
                         permittedArrowDirections:UIPopoverArrowDirectionAny
                                         animated:YES];
        
    }
    else
    {
        // Adjust the contentOffset so that the date cell is visible above the UIActionSheet
        UITableViewCell* cell = [self.tableViewController.tableView cellForRowAtIndexPath:indexPath];
        CGPoint contentOffset = self.tableViewController.tableView.contentOffset;
        _contentOffsetY = contentOffset.y;
        contentOffset.y = cell.frame.origin.y - (self.tableViewController.tableView.frame.size.height - 260) + cell.frame.size.height;
        _contentOffsetY = _contentOffsetY - contentOffset.y;
        [self.tableViewController.tableView setContentOffset:contentOffset animated:YES];

        UIActionSheet* actionSheet = [[UIActionSheet alloc] initWithTitle:self.label delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles: nil];
        self.actionSheet = actionSheet;
        [pickerToolbar setFrame:CGRectMake(0, 0, self.tableViewController.view.size.width, 44)];
        [datePicker setFrame:CGRectMake(0, 44, self.tableViewController.view.size.width, 216)];
        [actionSheet addSubview:pickerToolbar];
        [actionSheet addSubview:datePicker];
        [actionSheet showInView:self.tableViewController.view];
        [actionSheet setBounds:CGRectMake(0, 0, self.tableViewController.view.bounds.size.width, 464)];
    }
}

-(IBAction)timeSpanPickerCancelClick
{
    if (TTIsPad())
    {
        [self.popoverController dismissPopoverAnimated:YES];
        // Since we are programatically dismissing the popover, we must clean up ourselves.
        [self popoverControllerDidDismissPopover:self.popoverController];
    }
    else
    {
        [self.actionSheet dismissWithClickedButtonIndex:self.actionSheet.cancelButtonIndex animated:YES];
    }
}

-(IBAction)timeSpanPickerDoneClick
{
    [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithInt:_value1] forKey:USERDEFAULT_NEW_EVENT_SCHEDULE_TIME_SPAN_VALUE1];
    [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithInt:_value2] forKey:USERDEFAULT_NEW_EVENT_SCHEDULE_TIME_SPAN_VALUE2];

    if (TTIsPad())
    {
        [self.popoverController dismissPopoverAnimated:YES];
        // Since we are programatically dismissing the popover, we must clean up ourselves.
        [self popoverControllerDidDismissPopover:self.popoverController];
    }
    else
    {
        [self.actionSheet dismissWithClickedButtonIndex:1 animated:YES];
    }
    
    [self.tableViewController.tableView reloadData];
}

- (void) requestEndEditing
{
    if ([self.actionSheet isVisible])
        [self.actionSheet dismissWithClickedButtonIndex:self.actionSheet.cancelButtonIndex animated:YES];
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        switch (_value2) {
            case 0:
                return 1;
            case 1:
                return 5;
            case 2:
                return 8;
            case 3:
                return 7;
            case 4:
                return 4;
            case 5:
                return 12;
            case 6:
                return 6;
        }
    }
    else if(component == 1) {
        return 7;
    }

    return 0;
}

+(NSString*) titleForPickerValue2:(int)value2
{
    switch (value2) {
        case 0:
            return @"Immediately";
        case 1:
            return @"Minutes";
        case 2:
            return @"Hours";
        case 3:
            return @"Days";
        case 4:
            return @"Weeks";
        case 5:
            return @"Months";
        case 6:
            return @"Years";
        default:
            return @"Error";
    }
}

+(NSString*) titleForPickerValue1:(int)value1 withValue2:(int)value2
{
    static const int valuesMinutes[] = {5, 15, 30, 45, 60};
    static const int valuesHours[] = {1, 2, 3, 6, 9, 12, 18, 24};
    static const int valuesDays[] = {1, 2, 3, 4, 5, 6, 7};
    static const int valuesWeeks[] = {1, 2, 3, 4};
    static const int valuesMonths[] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12};
    static const int valuesYears[] = {1, 2, 3, 4, 5, 6};

    switch (value2) {
        case 0:
            return @"Immediately";
        case 1:
            return [NSString stringWithFormat:@"%d Minute%@",valuesMinutes[value1], valuesMinutes[value1] == 1 ? @"" : @"s"];
        case 2:
            return [NSString stringWithFormat:@"%d Hour%@",valuesHours[value1], valuesHours[value1] == 1 ? @"" : @"s"];
        case 3:
            return [NSString stringWithFormat:@"%d Day%@",valuesDays[value1], valuesDays[value1] == 1 ? @"" : @"s"];
        case 4:
            return [NSString stringWithFormat:@"%d Week%@",valuesWeeks[value1], valuesWeeks[value1] == 1 ? @"" : @"s"];
        case 5:
            return [NSString stringWithFormat:@"%d Month%@",valuesMonths[value1], valuesMonths[value1] == 1 ? @"" : @"s"];
        case 6:
            return [NSString stringWithFormat:@"%d Year%@",valuesYears[value1], valuesYears[value1] == 1 ? @"" : @"s"];
        default:
            return @"Error";
    }
}

+(NSDate*) addTimeIntervalToDate:(NSDate*)date forPickerValue1:(int)value1 withValue2:(int)value2
{
    static const int valuesMinutes[] = {5, 15, 30, 45, 60};
    static const int valuesHours[] = {1, 2, 3, 6, 9, 12, 18, 24};
    static const int valuesDays[] = {1, 2, 3, 4, 5, 6, 7};
    static const int valuesWeeks[] = {1, 2, 3, 4};
    static const int valuesMonths[] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12};
    static const int valuesYears[] = {1, 2, 3, 4, 5, 6};

    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    
    switch (value2) {
        case 0:
            components.day = 0;
            break;
        case 1:
              components.minute = valuesMinutes[value1];
            break;
        case 2:
              components.hour = valuesHours[value1];
            break;
        case 3:
            components.day = valuesDays[value1];
            break;
        case 4:
            components.week = valuesWeeks[value1];
            break;
        case 5:
            components.month = valuesMonths[value1];
            break;
        case 6:
            components.year = valuesYears[value1];
            break;
    }

    NSDate *newDate = [gregorian dateByAddingComponents:components toDate:date options:0];

    return newDate;
}

+(NSDate*) addTimeIntervalToDate:(NSDate*)date
{
    NSNumber* value1 = [[NSUserDefaults standardUserDefaults] valueForKey:USERDEFAULT_NEW_EVENT_SCHEDULE_TIME_SPAN_VALUE1];
    NSNumber* value2 = [[NSUserDefaults standardUserDefaults] valueForKey:USERDEFAULT_NEW_EVENT_SCHEDULE_TIME_SPAN_VALUE2];
    int _value1 = [value1 intValue];
    int _value2 = [value2 intValue];

    return [DetailViewTimeSpanCell addTimeIntervalToDate:date forPickerValue1:_value1 withValue2:_value2];
}

@end

@implementation DetailViewTimeSpanCell (UIPickerViewDelegate)

-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return component == 0 ? 60 : 200;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    static const int valuesMinutes[] = {5, 15, 30, 45, 60};
    static const int valuesHours[] = {1, 2, 3, 4, 5, 6, 9, 12, 18, 24};
    static const int valuesDays[] = {1, 2, 3, 4, 5, 6, 7};
    static const int valuesWeeks[] = {1, 2, 3, 4};
    static const int valuesMonths[] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12};
    static const int valuesYears[] = {1, 2, 3, 4, 5, 6};
    
    if (component == 0)
    {
        switch (_value2) {
            case 0:
                return @"-";
            case 1:
                return [NSString stringWithFormat:@"%d", valuesMinutes[row]];
            case 2:
                return [NSString stringWithFormat:@"%d", valuesHours[row]];
            case 3:
                return [NSString stringWithFormat:@"%d", valuesDays[row]];
            case 4:
                return [NSString stringWithFormat:@"%d", valuesWeeks[row]];
            case 5:
                return [NSString stringWithFormat:@"%d", valuesMonths[row]];
            case 6:
                return [NSString stringWithFormat:@"%d", valuesYears[row]];
        }
    } else if (component == 1)
    {
        return [DetailViewTimeSpanCell titleForPickerValue2:row];
    }
    
    return @"";
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0)
    {
        _value1 = row;
    }
    else if (component == 1)
    {
        if (_value2 != row)
        {
            _value1 = 0;
            _value2 = row;
            [pickerView reloadAllComponents];
            [pickerView selectRow:_value1 inComponent:0 animated:YES];
            [pickerView selectRow:_value2 inComponent:1 animated:YES];
        }
    }
}

@end

@implementation DetailViewTimeSpanCell (UIActionSheetDelegate)
-(void) actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    self.actionSheet = nil;
}

@end

@implementation DetailViewTimeSpanCell (UIPopoverControllerDelegate)

-(void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    self.popoverController = nil;
}

@end

