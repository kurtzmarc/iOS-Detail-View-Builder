//
//  DetailViewEventNameCell.m
//  Face Charts
//
//  Created by Marc Kurtz on 10/4/11.
//  Copyright 2011 Kurtz Consulting Services LLC. All rights reserved.
//

#define DEFAULT_NEW_RECORD_NAME @"New Record"

#import "DetailViewEventNameCell.h"
#import "DVB_DetailView.h"

@implementation DetailViewEventNameCell

- (void)configureCell:(UITableViewCell *)cell
{
    [super configureCell:cell];

    UITextView* textView = (UITextView*) [cell viewWithTag:kTextFieldTag];
    if ([textView.text isEqualToString:[self defaultNewRecordName]])
    {
        textView.textColor = [UIColor lightGrayColor];
    }
}

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([[self superclass] instancesRespondToSelector:@selector(textViewDidBeginEditing:)])
        [super textViewDidBeginEditing:textView];
    
    if ([textView.text isEqualToString:[self defaultNewRecordName]])
    {
        textView.textColor = [UIColor blackColor];
        textView.text = @"";
    }
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""] || [textView.text isEqualToString:[self defaultNewRecordName]])
    {
        textView.textColor = [UIColor lightGrayColor];
        textView.text = [self defaultNewRecordName];
    }

    if ([[self superclass] instancesRespondToSelector:@selector(textViewDidEndEditing:)])
        [super textViewDidEndEditing:textView];
}

-(NSString*) defaultNewRecordName
{
    return DEFAULT_NEW_RECORD_NAME;
}

@end
