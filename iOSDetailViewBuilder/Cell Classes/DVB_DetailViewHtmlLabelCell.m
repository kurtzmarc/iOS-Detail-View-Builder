//
//  DVB_DetailViewHtmlLabelCell.m
//  iOSDetailViewBuilder
//
//  Created by Marc Kurtz on 2/12/12.
//  Copyright 2012 Kurtz Consulting Services LLC. All rights reserved.
//

#import "DVB_DetailViewHtmlLabelCell.h"

@implementation DVB_DetailViewHtmlLabelCell

int height;

- (NSString*)cellIdentifier
{
    return @"BuilderLabelCell";
}

- (UITableViewCell*) createCell
{
    UITableViewCell* cell;
    
    cell = [self createLabelCell];
    if (self.onCellCreated)
        self.onCellCreated(cell);
    return cell;
}

-(CGFloat)height
{
    /*if (height == 0)
    {
        UIWebView* webView = [[UIWebView alloc] init];
        [webView loadHTMLString:self.label baseURL:nil];
        [webView sizeThatFits:CGSizeMake(300, CGFLOAT_MAX)];
        //label.font = [UIFont systemFontOfSize:10.0];
        //label.text = self.label;
        //CGRect textSize = [label textRectForBounds:CGRectMake(0, 0, 300, CGFLOAT_MAX) limitedToNumberOfLines:0];
        height = webView.frame.size.height;
    }
    return height + 10;*/
    return 300;
}

- (void) configureCell:(UITableViewCell*) cell
{
    UILabel* label = (UILabel*)[cell.contentView viewWithTag:kLabelTag];
    label.text = self.label;
    CGRect textSize = [label textRectForBounds:CGRectMake(0, 0, 300, CGFLOAT_MAX) limitedToNumberOfLines:0];
    height = textSize.size.height;
    label.bounds = textSize;
    [super configureCell:cell];
}

#define GROUPED_CELL_WIDTH 300
#define CELL_PADDING 5

- (UITableViewCell*) createLabelCell {
    UITableViewCell* cell;
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:self.cellIdentifier];
    cell.clipsToBounds = YES;
    cell.backgroundColor = [UIColor whiteColor];
    
    CGRect cellRect = cell.frame;
    CGRect labelRect = CGRectZero;
    cellRect.size.width = GROUPED_CELL_WIDTH;

    // Add label
    labelRect = CGRectMake(cell.frame.origin.x, cell.frame.origin.y, cellRect.size.width, cellRect.size.height);
    labelRect = CGRectInset(labelRect, CELL_PADDING, CELL_PADDING);
    UIWebView* webView = [[UIWebView alloc] initWithFrame:labelRect];
    [webView loadHTMLString:self.label baseURL:nil];
    //label.tag = kLabelTag;
    webView.backgroundColor = [UIColor whiteColor];
    webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    webView.delegate = self;
    CGRect frame = webView.frame;
    frame.size.height = 300;
    //label.frame = frame;
    height = frame.size.height;
    [cell.contentView addSubview:webView];
    
    return cell;
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if (navigationType == UIWebViewNavigationTypeLinkClicked)
    {
        [[UIApplication sharedApplication] openURL:request.URL];
    }
    return navigationType == UIWebViewNavigationTypeOther || navigationType == UIWebViewNavigationTypeReload;
}

@end
