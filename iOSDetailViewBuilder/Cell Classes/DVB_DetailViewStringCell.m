//
//  Copyright 2013 Kurtz Consulting Services LLC.
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
    _textView.spellCheckingType = self.spellCheckingType;
    
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
        }
    }
}

-(void) resizeTableView
{
    [self.tableViewController.tableView beginUpdates];
    [self.tableViewController.tableView endUpdates];
}

-(void)adjustTextView:(UITextView*) textView
{
    CGFloat calculatedHeight = [textView sizeThatFits:CGSizeMake(textView.frame.size.width, FLT_MAX)].height;
    calculatedHeight += 9; // To account for UITextView offset within UITableViewCell
    
    if (calculatedHeight != _cellHeight){
        _cellHeight = calculatedHeight;
        CGRect frame = textView.frame;
        frame.size.height = _cellHeight - 9; // To account for UITextView offset within UITableViewCell
        textView.frame = frame;
        [self performSelector:@selector(resizeTableView) withObject:nil afterDelay:0.0];
    }
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

-(void)textViewDidChange:(UITextView *)textView
{
    [self adjustTextView:textView];
}

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    CGRect cursorRect = [textView caretRectForPosition:textView.selectedTextRange.start];
    
    cursorRect = [self.tableViewController.tableView convertRect:cursorRect fromView:textView];
    
    if (![self rectVisible:cursorRect]) {
        cursorRect.size.height += 8; // To add some space underneath the cursor
        [self.tableViewController.tableView scrollRectToVisible:cursorRect animated:YES];
    }
}
- (BOOL)rectVisible: (CGRect)rect {
    CGRect visibleRect;
    visibleRect.origin = self.tableViewController.tableView.contentOffset;
    visibleRect.origin.y += self.tableViewController.tableView.contentInset.top;
    visibleRect.size = self.tableViewController.tableView.bounds.size;
    visibleRect.size.height -= self.tableViewController.tableView.contentInset.top + self.tableViewController.tableView.contentInset.bottom;
    
    return CGRectContainsRect(visibleRect, rect);
}
@end
