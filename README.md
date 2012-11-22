# BBAlertView

BBAlertView is [UIAlertView](http://developer.apple.com/library/ios/#documentation/UIKit/Reference/UIAlertView_Class/UIAlertView/UIAlertView.html) with blocks.

## How to use it

It's super easy.
First, create a new BBAlertView object

    BBAlertView * alerView = [BBAlertView alertWithTitle:@"Title goes here" 
    											 message:@"and message here"];
    
Setup every button you want with a title and an action for it in a block (or just NULL)

    [alerView setCancelButtonWithTitle:@"Cancel" onTapDo:^{
        
        NSLog(@"Cancel button was tapped");
        
    }];
    
    [alerView addButtonWithTitle:@"Other Button" onTapDo:^{
        
        NSLog(@"Other button was tapped");
        
    }];

And finally show it

    [alerView show];
    

That's it!