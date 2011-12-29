//
//  DetailViewEventNameCell.m
//  Face Charts
//
//  Created by Marc Kurtz on 10/4/11.
//  Copyright 2011 Kurtz Consulting Services LLC. All rights reserved.
//

#import "DetailViewEventNameCell.h"
#import "DVB_DetailView.h"
#import "Constants.h"

@implementation DetailViewEventNameCell

- (void)configureCell:(UITableViewCell *)cell
{
    [super configureCell:cell];

    UITextView* textView = (UITextView*) [cell viewWithTag:kTextFieldTag];
    if ([textView.text isEqualToString:DEFAULT_NEW_EVENT_NAME])
    {
        textView.textColor = [UIColor lightGrayColor];
    }
}

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([[self superclass] instancesRespondToSelector:@selector(textViewDidBeginEditing:)])
        [super textViewDidBeginEditing:textView];
    
    if ([textView.text isEqualToString:DEFAULT_NEW_EVENT_NAME])
    {
        textView.textColor = [UIColor blackColor];
        textView.text = @"";
    }
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""] || [textView.text isEqualToString:DEFAULT_NEW_EVENT_NAME])
    {
        textView.textColor = [UIColor lightGrayColor];
        textView.text = DEFAULT_NEW_EVENT_NAME;
    }

    if ([[self superclass] instancesRespondToSelector:@selector(textViewDidEndEditing:)])
        [super textViewDidEndEditing:textView];
}

@end
