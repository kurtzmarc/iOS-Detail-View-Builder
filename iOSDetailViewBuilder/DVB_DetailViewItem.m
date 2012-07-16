//
//  DVB_DetailViewItem.m
//  iOSDetailViewBuilder
//
//  Created by Marc Kurtz on 6/26/11.
//  Copyright 2011 Kurtz Consulting Services LLC. All rights reserved.
//

#import "DVB_DetailViewItem.h"
#import "DVB_DetailViewBuilder.h"
#import "DVB_DetailViewDataManager.h"
#import "TTGlobalUICommon.h"
#import "DVB_ExpandableTextView.h"

#define GROUPED_CELL_WIDTH 300
#define CELL_PADDING 5

@implementation DVB_DetailViewItem

@synthesize dataManager = _dataManager;
@synthesize label = _label;
@synthesize key = _key;
@synthesize tableViewController = _tableViewController;
@synthesize builder = _builder;
@synthesize onSelectCell = _onSelectCell;
@synthesize onConfigureCell = _onConfigureCell;
@synthesize onCellCreated = _onCellCreated;

- (id)initWithLabel:(NSString*) labelString
    withDataManager:(DVB_DetailViewDataManager*) dataManager
            withKey:(NSString*) key
     withController:(UITableViewController*) controller
        withBuilder:(DVB_DetailViewBuilder*) builder
{
    self = [super init];
    if (self) {
        self.label = labelString;
        self.dataManager = dataManager;
        self.key = key;
        self.tableViewController = controller;
        self.builder = builder;
    }
    return self;
}


- (CGFloat) height
{
    return ttkDefaultRowHeight;
}

- (NSString*)cellIdentifier
{
    @throw [NSException exceptionWithName:@"InternalCodingException" reason:@"Internal coding exception - 'cellIdentifier' method not implemented in class." userInfo:nil];
}

- (UITableViewCell*) createCell
{
    @throw [NSException exceptionWithName:@"InternalCodingException" reason:@"Internal coding exception - 'createCell' method not implemented in class." userInfo:nil];
}

- (void) cellCreated:(UITableViewCell*) cell
{
    if (self.onCellCreated)
        self.onCellCreated(cell);
}

- (UITableViewCell*) createStockCellWithDelegate:(id<UITextViewDelegate>) delegate isEditable:(BOOL) editable {
    UITableViewCell* cell;
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:self.cellIdentifier];
    cell.clipsToBounds = YES;
    
    // Calculate layout
    CGRect cellRect = cell.frame;
    CGRect labelRect = CGRectZero, textFieldRect = CGRectZero;
    cellRect.size.width = GROUPED_CELL_WIDTH;
    CGRectDivide(cellRect, &labelRect, &textFieldRect, cellRect.size.width * 0.3, CGRectMinXEdge);
    labelRect = CGRectInset(labelRect, CELL_PADDING, 0);
    textFieldRect = CGRectInset(textFieldRect, CELL_PADDING, 4.5);
    
    // Add label
    UILabel* label = [[UILabel alloc] initWithFrame:labelRect];
    label.text = self.label;
    label.tag = kLabelTag;
    label.textColor = [UIColor colorWithRed:0.32 green:0.40 blue:0.57 alpha:1.0];
    label.font = [UIFont boldSystemFontOfSize:12];
    label.textAlignment = UITextAlignmentRight;
    label.backgroundColor = [UIColor clearColor];
    [cell.contentView addSubview:label];
    
    // Add text field
    DVB_ExpandableTextView *textField = [[DVB_ExpandableTextView alloc] initWithFrame:textFieldRect];
    textField.backgroundColor = [UIColor clearColor];
    textField.scrollEnabled = NO;
    textField.userInteractionEnabled = NO;
    textField.delegate = delegate;
    textField.font = [UIFont boldSystemFontOfSize:15];
    textField.tag = kTextFieldTag;
    //textField.returnKeyType = UIReturnKeyDone;
    textField.autoresizingMask =  UIViewAutoresizingFlexibleWidth;// | UIViewAutoresizingFlexibleHeight ;
    //textField.enablesReturnKeyAutomatically = YES;
    [cell.contentView addSubview:textField];
    
    return cell;
}

- (void) configureCell:(UITableViewCell*) cell
{
    if (self.onConfigureCell)
        self.onConfigureCell(cell);
}

- (void) didSelectCell:(NSIndexPath*)indexPath
{
    if (self.onSelectCell)
        self.onSelectCell();
}

- (void) requestEndEditing
{
    @throw [NSException exceptionWithName:@"InternalCodingException" reason:@"Internal coding exception - 'requestEndEditing' method not implemented in class." userInfo:nil];
}
@end
