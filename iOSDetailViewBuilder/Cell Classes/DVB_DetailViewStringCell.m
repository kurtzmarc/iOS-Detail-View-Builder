//
//  DVB_DetailViewTextCell.m
//  Face Charts
//
//  Created by Marc Kurtz on 7/30/11.
//  Copyright 2011 Kurtz Consulting Services LLC. All rights reserved.
//

#import "DVB_DetailViewStringCell.h"
#import "DVB_DetailViewDataManager.h"
#import "DVB_DetailViewBuilder.h"

@implementation DVB_DetailViewStringCell

- (id)initWithLabel:(NSString *) labelString
    withDataManager:(DVB_DetailViewDataManager*) dataManager
            withKey:(NSString*) key
     withController:(UITableViewController*) controller
        withBuilder:(DVB_DetailViewBuilder*) builder
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
    return [@"BuilderStringCell-" stringByAppendingString:self.key];
}

- (UITableViewCell*) createCell
{
    UITableViewCell* cell = [self createStockCellWithDelegate:self isEditable:YES];
    UITextView* textView = (UITextView*) [cell viewWithTag:kTextFieldTag];
    [textView addObserver:self forKeyPath:@"contentSize" options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld) context:nil];
    return cell;
}

- (void) configureCell:(UITableViewCell*) cell
{
    _cellHeight = 0;

    NSString* value = (NSString*)[self.dataManager getValue:self];
    UITextView* textView = (UITextView*) [cell viewWithTag:kTextFieldTag];
    textView.text = value;
    [self adjustTextView:textView];

    UILabel* label = (UILabel*) [cell viewWithTag:kLabelTag];
    label.text = self.label;
}

- (void) didSelectCell:(NSIndexPath*)indexPath
{
    UITableViewCell* cell = [self.tableViewController.tableView cellForRowAtIndexPath:indexPath];
    UITextView* textView = (UITextView*) [cell viewWithTag:kTextFieldTag];
    textView.userInteractionEnabled = YES;
    [textView becomeFirstResponder];
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

        CGFloat topCorrect = (/*self.textViewHidden.bounds.size.height*/ _cellHeight - textView.contentSize.height * textView.zoomScale)  / 2.0;
        if (textView.text.length == 0)
            topCorrect = 4.5;
        topCorrect = ( topCorrect < 0.0 ? 0.0 : topCorrect );
        textView.contentOffset = (CGPoint){.x = 0, .y = -topCorrect};

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
    _cellHeight = MAX(textView.contentSize.height, ttkDefaultRowHeight);
    
    if (textView.text.length == 0)
        _cellHeight = ttkDefaultRowHeight;
    
    CGRect frame = textView.frame;
    frame.size.height = _cellHeight;
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
