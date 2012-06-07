//
//  DVB_DetailViewTextCell.m
//  iOSDetailViewBuilder
//
//  Created by Marc Kurtz on 7/30/11.
//  Copyright 2011 Kurtz Consulting Services LLC. All rights reserved.
//

#import "DVB_DetailViewStringCell.h"
#import "DVB_DetailViewDataManager.h"
#import "DVB_DetailViewBuilder.h"
#import "TTGlobalUICommon.h"

@implementation DVB_DetailViewStringCell

@synthesize autocapitalizationType = _autocapitalizationType;
@synthesize autocorrectionType = _autocorrectionType;
@synthesize enablesReturnKeyAutomatically = _enablesReturnKeyAutomatically;
@synthesize keyboardAppearance = _keyboardAppearance;
@synthesize keyboardType = _keyboardType;
@synthesize returnKeyType = _returnKeyType;
@synthesize secureTextEntry = _secureTextEntry;
@synthesize spellCheckingType = _spellCheckingType;

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
    if (_cellHeight == 0)
    {
        _cellHeight = ttkDefaultRowHeight;
    }
    return _cellHeight;
}

- (NSString*)cellIdentifier
{
    return [@"BuilderStringCell-" stringByAppendingString:self.key];
}

- (UITableViewCell*) createCell
{
    UITableViewCell* cell = [self createStockCellWithDelegate:self isEditable:YES];
    UITextView* textView = (UITextView*) [cell viewWithTag:kTextFieldTag];
    [textView addObserver:self forKeyPath:@"contentSize" options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld) context:nil];
    if (self.onCellCreated)
        self.onCellCreated(cell);
    return cell;
}

- (void) configureCell:(UITableViewCell*) cell
{
    _cellHeight = 0;

    NSString* value = (NSString*)[self.dataManager getValue:self];
    UITextView* textView = (UITextView*) [cell viewWithTag:kTextFieldTag];
    textView.text = value;
    textView.autocapitalizationType = self.autocapitalizationType;
    textView.autocorrectionType = self.autocorrectionType;
    textView.enablesReturnKeyAutomatically = self.enablesReturnKeyAutomatically;
    textView.keyboardAppearance = self.keyboardAppearance;
    textView.keyboardType = self.keyboardType;
    textView.returnKeyType = self.returnKeyType;
    textView.secureTextEntry = self.secureTextEntry;
    if (TTOSVersionIsAtLeast(5.0))
    {
        textView.spellCheckingType = self.spellCheckingType;
    }
    
    [self adjustTextView:textView];

    UILabel* label = (UILabel*) [cell viewWithTag:kLabelTag];
    label.text = self.label;
    [super configureCell:cell];
}

- (void) didSelectCell:(NSIndexPath*)indexPath
{
    UITableViewCell* cell = [self.tableViewController.tableView cellForRowAtIndexPath:indexPath];
    UITextView* textView = (UITextView*) [cell viewWithTag:kTextFieldTag];
    textView.userInteractionEnabled = YES;
    [textView becomeFirstResponder];
    [super didSelectCell:indexPath];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"contentSize"])
    {
        CGSize newSize = [[change objectForKey:NSKeyValueChangeNewKey] CGSizeValue];
        CGSize oldSize = [[change objectForKey:NSKeyValueChangeOldKey] CGSizeValue];
        UITextView* textView = (UITextView*)object;
        if (!CGSizeEqualToSize(newSize, oldSize))
        {
            [self adjustTextView:textView];

            [self performSelector:@selector(resizeTableView) withObject:nil afterDelay:0.0];
        }
    }
    else
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
}

-(void) resizeTableView
{
    [self.tableViewController.tableView beginUpdates];
    [self.tableViewController.tableView endUpdates];
}

-(void)adjustTextView:(UITextView*) textView
{
    _cellHeight = MAX(textView.contentSize.height + 4.5, ttkDefaultRowHeight);
    
    if (textView.text.length == 0)
        _cellHeight = ttkDefaultRowHeight;
    
    CGRect frame = textView.frame;
    frame.size.height = _cellHeight - 9;
    textView.frame = frame;
}

- (void) requestEndEditing
{
    NSIndexPath* indexPath = [self.builder indexPathForItem:self];
    UITableViewCell* cell = [self.tableViewController.tableView cellForRowAtIndexPath:indexPath];
    UITextView* textView = (UITextView*) [cell viewWithTag:kTextFieldTag];
    [textView endEditing:YES];
}

@end

@implementation DVB_DetailViewStringCell (UITextViewDelegate)
-(void)textViewDidEndEditing:(UITextView *)textView
{
    textView.userInteractionEnabled = NO;
    [textView resignFirstResponder];
    [self.dataManager setValue:textView.text forItem:self];

    [self.tableViewController.tableView beginUpdates];
    [self.tableViewController.tableView endUpdates];
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

@end
