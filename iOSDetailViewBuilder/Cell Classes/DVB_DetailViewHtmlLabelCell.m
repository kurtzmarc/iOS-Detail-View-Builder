//
//  Copyright 2013 Kurtz Consulting Services LLC.
//

#import "DVB_DetailViewHtmlLabelCell.h"

@implementation DVB_DetailViewHtmlLabelCell

int height;

- (NSString*)cellIdentifier
{
    return @"HtmlLabelCell";
}

- (UITableViewCell*) createCell
{
    UITableViewCell* cell;
    
    cell = [self createLabelCell];
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
    [super configureCell:cell];
}

- (UITableViewCell*) createLabelCell {
    UITableViewCell* cell;
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:self.cellIdentifier];
    cell.clipsToBounds = YES;
    
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
