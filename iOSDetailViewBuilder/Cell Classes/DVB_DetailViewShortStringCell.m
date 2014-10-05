//
//  Copyright 2013 Kurtz Consulting Services LLC.
//

#import "DVB_DetailViewShortStringCell.h"
#import "DVB_DetailViewDataManager.h"
#import "DVB_DetailViewBuilder.h"
#import "TTGlobalUICommon.h"

#define GROUPED_CELL_WIDTH 300
#define CELL_PADDING 5

@implementation DVB_DetailViewShortStringCell
{
    __weak UITextField* _textField;
}

@synthesize autocapitalizationType = _autocapitalizationType;
@synthesize autocorrectionType = _autocorrectionType;
@synthesize enablesReturnKeyAutomatically = _enablesReturnKeyAutomatically;
@synthesize keyboardAppearance = _keyboardAppearance;
@synthesize keyboardType = _keyboardType;
@synthesize returnKeyType = _returnKeyType;
@synthesize secureTextEntry = _secureTextEntry;
@synthesize spellCheckingType = _spellCheckingType;
@synthesize onTextChanged = _onTextChanged;

- (id)initWithLabel:(NSString *) labelString
    withDataManager:(DVB_DetailViewDataManager*) dataManager
            withKey:(NSString*) key
     withController:(UITableViewController*) controller
        withBuilder:(DVB_DetailViewBuilder*) builder
{
    self = [super initWithLabel:labelString withDataManager:dataManager withKey:key withController:controller withBuilder:builder];
    if (self) {
        _cellHeight = 0;
        _autocapitalizationType = UITextAutocapitalizationTypeSentences;
        _autocorrectionType = UITextAutocorrectionTypeDefault;
        _enablesReturnKeyAutomatically = NO;
        _keyboardAppearance = UIKeyboardAppearanceDefault;
        _keyboardType = UIKeyboardTypeDefault;
        _returnKeyType = UIReturnKeyDone;
        _secureTextEntry = NO;
        _spellCheckingType = UITextSpellCheckingTypeDefault;
    }
    return self;
}

-(CGFloat)height
{
    return MAX(_cellHeight, ttkDefaultRowHeight);
}

- (NSString*)cellIdentifier
{
    return [@"BuilderStringCell-" stringByAppendingString:self.key];
}

- (UITableViewCell*) createCell
{
    UITableViewCell* cell = [self createStockCell];
    return cell;
}

- (UITableViewCell*) createStockCell {
    UITableViewCell* cell;
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:self.cellIdentifier];
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
    label.textAlignment = NSTextAlignmentRight;
    label.backgroundColor = [UIColor clearColor];
    label.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    label.numberOfLines = 0;
    [cell.contentView addSubview:label];
    
    // Add text field
    UITextField *textField = [[UITextField alloc] initWithFrame:textFieldRect];
    textField.backgroundColor = [UIColor clearColor];
    textField.userInteractionEnabled = NO;
    textField.font = [UIFont boldSystemFontOfSize:15];
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    textField.tag = kTextFieldTag;
    //textField.returnKeyType = UIReturnKeyDone;
    textField.autoresizingMask =  UIViewAutoresizingFlexibleWidth;// | UIViewAutoresizingFlexibleHeight ;
    //textField.enablesReturnKeyAutomatically = YES;
    [cell.contentView addSubview:textField];
    
    return cell;
}

- (void) configureCell:(UITableViewCell*) cell
{
    _cellHeight = 0;

    NSString* value = (NSString*)[self.dataManager getValue:self];
    _textField = (UITextField*) [cell viewWithTag:kTextFieldTag];
    _textField.text = value;
    _textField.autocapitalizationType = self.autocapitalizationType;
    _textField.autocorrectionType = self.autocorrectionType;
    _textField.enablesReturnKeyAutomatically = self.enablesReturnKeyAutomatically;
    _textField.keyboardAppearance = self.keyboardAppearance;
    _textField.keyboardType = self.keyboardType;
    _textField.returnKeyType = self.returnKeyType;
    _textField.secureTextEntry = self.secureTextEntry;
    _textField.delegate = self;
    _textField.spellCheckingType = self.spellCheckingType;
    
    UILabel* label = (UILabel*) [cell viewWithTag:kLabelTag];
    label.text = self.label;
    [super configureCell:cell];
}

- (void) didSelectCell:(NSIndexPath*)indexPath
{
    _textField.userInteractionEnabled = YES;
    [_textField becomeFirstResponder];
    [super didSelectCell:indexPath];
}

-(void) resizeTableView
{
    [self.tableViewController.tableView beginUpdates];
    [self.tableViewController.tableView endUpdates];
}

- (void) requestEndEditing
{
    [_textField endEditing:YES];
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    textField.userInteractionEnabled = NO;
    [textField resignFirstResponder];
    [self.dataManager setValue:textField.text forItem:self];
    if (self.onTextChanged)
        self.onTextChanged(textField.text);
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string isEqualToString:@"\n"])
    {
        [textField resignFirstResponder];
        return NO;
    }
    return YES;
}

//-(void)textViewDidBeginEditing:(UITextView *)textView
//{
//    CGRect cursorRect = [textView caretRectForPosition:textView.selectedTextRange.start];
//    
//    cursorRect = [self.tableViewController.tableView convertRect:cursorRect fromView:textView];
//    
//    if (![self rectVisible:cursorRect]) {
//        cursorRect.size.height += 8; // To add some space underneath the cursor
//        [self.tableViewController.tableView scrollRectToVisible:cursorRect animated:YES];
//    }
//}
//- (BOOL)rectVisible: (CGRect)rect {
//    CGRect visibleRect;
//    visibleRect.origin = self.tableViewController.tableView.contentOffset;
//    visibleRect.origin.y += self.tableViewController.tableView.contentInset.top;
//    visibleRect.size = self.tableViewController.tableView.bounds.size;
//    visibleRect.size.height -= self.tableViewController.tableView.contentInset.top + self.tableViewController.tableView.contentInset.bottom;
//    
//    return CGRectContainsRect(visibleRect, rect);
//}
@end
