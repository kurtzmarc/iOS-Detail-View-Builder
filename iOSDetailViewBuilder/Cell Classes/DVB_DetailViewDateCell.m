//
//  DVB_DetailViewDateCell.m
//  iOSDetailViewBuilder
//
//  Created by Marc Kurtz on 7/30/11.
//  Copyright 2011 Kurtz Consulting Services LLC. All rights reserved.
//

#import "DVB_DetailViewDateCell.h"
#import "DVB_DetailViewDataManager.h"
#import "DVB_DetailViewBuilder.h"
#import "TTGlobalUICommon.h"

@implementation DVB_DetailViewDateCell

@synthesize popoverController = _popoverController;
@synthesize actionSheet = _actionSheet;
@synthesize datePicker = _datePicker;

- (id)initWithLabel:(NSString *) labelString
    withDataManager:(DVB_DetailViewDataManager*) dataManager
            withKey:(NSString*) key
     withController:(UITableViewController*) controller
        withBuilder:(DVB_DetailViewBuilder*) builder
{
    self = [super initWithLabel:labelString withDataManager:dataManager withKey:key withController:controller withBuilder:builder];
    if (self) {
        _contentOffsetY = 0;
    }
    return self;
}

- (NSString*)cellIdentifier
{
    return [@"BuilderDateCell-" stringByAppendingString:self.key];
}

- (UITableViewCell*) createCell
{
    UITableViewCell* cell = [self createStockCellWithDelegate:nil isEditable:NO];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    // Give a little more width to date cells...
    UITextView* textView = (UITextView*) [cell viewWithTag:kTextFieldTag];
    CGRect textViewFrame = textView.frame;
    textViewFrame.size.width += 25;
    textView.frame = textViewFrame;
    if (self.onCellCreated)
        self.onCellCreated(cell);
    return cell;
}

- (void) configureCell:(UITableViewCell*) cell
{
    NSDate* date = (NSDate*) [self.dataManager getValue:self]; // [self.builder.managedObject valueForKeyPath:self.keyPath];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    NSString *dateStr = [formatter stringFromDate:date];

    UITextView* textView = (UITextView*) [cell viewWithTag:kTextFieldTag];
    textView.text = dateStr;
    UILabel* label = (UILabel*) [cell viewWithTag:kLabelTag];
    label.text = self.label;
    [super configureCell:cell];
}

- (void) didSelectCell:(NSIndexPath*)indexPath
{
    [self.tableViewController.view endEditing:YES];
    
    UIDatePicker* datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 44, 320, 216)];
    self.datePicker = datePicker;
    datePicker.datePickerMode = UIDatePickerModeDateAndTime;
    datePicker.minuteInterval = 5;
    NSObject* obj = [self.dataManager getValue:self];

    if (obj)
        datePicker.date = (NSDate*)obj;
    else
        datePicker.date = [NSDate date];
    
    UIToolbar* pickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    pickerToolbar.barStyle=UIBarStyleBlackOpaque;
    
    NSMutableArray *barItems = [[NSMutableArray alloc] init];   
    UIBarButtonItem *cancelBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(datePickerCancelClick)];
    [barItems addObject:cancelBtn];
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc]
                                  initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                  target:nil
                                  action:nil];
    [barItems addObject:flexSpace];
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(datePickerDoneClick)];
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
        [pickerToolbar setFrame:CGRectMake(0, 0, self.tableViewController.view.frame.size.width, 44)];
        [datePicker setFrame:CGRectMake(0, 44, self.tableViewController.view.frame.size.width, 216)];
        [actionSheet addSubview:pickerToolbar];
        [actionSheet addSubview:datePicker];
        [actionSheet showInView:self.tableViewController.view];
        [actionSheet setBounds:CGRectMake(0, 0, self.tableViewController.view.bounds.size.width, 464)];
    }
    [super onSelectCell];
}

-(IBAction)datePickerCancelClick
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

        //NSIndexPath* indexPath = [self.builder indexPathForItem:self];
        //[self.tableViewController.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    }
}

-(IBAction)datePickerDoneClick
{
    [self.dataManager setValue:self.datePicker.date forItem:self];

    if (TTIsPad())
    {
        [self.popoverController dismissPopoverAnimated:YES];
        // Since we are programatically dismissing the popover, we must clean up ourselves.
        [self popoverControllerDidDismissPopover:self.popoverController];
    }
    else
    {
        [self.actionSheet dismissWithClickedButtonIndex:1 animated:YES];

        /*if (_contentOffsetY)
        {
            CGPoint contentOffset = self.tableViewController.tableView.contentOffset;
            contentOffset.y += _contentOffsetY;
            [self.tableViewController.tableView setContentOffset:contentOffset animated:YES];
            _contentOffsetY = 0;
        }*/
        
        //NSIndexPath* indexPath = [self.builder indexPathForItem:self];
        //[self.tableViewController.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    }
}

- (void) requestEndEditing
{
    if ([self.actionSheet isVisible])
        [self.actionSheet dismissWithClickedButtonIndex:self.actionSheet.cancelButtonIndex animated:YES];
}


@end

@implementation DVB_DetailViewDateCell (UIActionSheetDelegate)
-(void) actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    self.actionSheet = nil;
}

@end

@implementation DVB_DetailViewDateCell (UIPopoverControllerDelegate)

-(void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    self.popoverController = nil;
}

@end

