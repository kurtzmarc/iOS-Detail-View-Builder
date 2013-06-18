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
{
    __weak UITextView* _textView;
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
    UITableViewCell* cell = [self createStockCell];
    UITextView* textView = (UITextView*) [cell viewWithTag:kTextFieldTag];
    [textView addObserver:self forKeyPath:@"contentSize" options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld) context:nil];
    return cell;
}

- (void) configureCell:(UITableViewCell*) cell
{
    _cellHeight = 0;

    NSString* value = (NSString*)[self.dataManager getValue:self];
    _textView = (UITextView*) [cell viewWithTag:kTextFieldTag];
    _textView.text = value;
    _textView.autocapitalizationType = self.autocapitalizationType;
    _textView.autocorrectionType = self.autocorrectionType;
    _textView.enablesReturnKeyAutomatically = self.enablesReturnKeyAutomatically;
    _textView.keyboardAppearance = self.keyboardAppearance;
    _textView.keyboardType = self.keyboardType;
    _textView.returnKeyType = self.returnKeyType;
    _textView.secureTextEntry = self.secureTextEntry;
    _textView.delegate = self;
    if (TTOSVersionIsAtLeast(5.0))
    {
        _textView.spellCheckingType = self.spellCheckingType;
    }
    
    [self adjustTextView:_textView];

    UILabel* label = (UILabel*) [cell viewWithTag:kLabelTag];
    label.text = self.label;
    [super configureCell:cell];
}

- (void) didSelectCell:(NSIndexPath*)indexPath
{
    _textView.userInteractionEnabled = YES;
    [_textView becomeFirstResponder];
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
    [_textView endEditing:YES];
}

@end

@implementation DVB_DetailViewStringCell (UITextViewDelegate)
-(void)textViewDidEndEditing:(UITextView *)textView
{
    textView.userInteractionEnabled = NO;
    [textView resignFirstResponder];
    [self.dataManager setValue:textView.text forItem:self];
    if (self.onTextChanged)
        self.onTextChanged(textView.text);

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
