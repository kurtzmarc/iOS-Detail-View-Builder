iOS Detail View Builder
====================

A Quick Introduction
---------------------
I could see early-on in learning UIKit that UITableView management in a detail view is a repetative thankless job. You can try to come up with some half-assed scheme to get you by, but that quickly becomes a maintenance nightmare. I also knew that I needed to dig into Objective-C and learn how to write reusable code. iOS Detail View Builder is my attempt to write a flexible, maintainable, and easy to use detail view building library. I'm not saying I've acheived any of those things, but...

Quickstart
------------
The general idea is that you create a data manager for the type of data you want to use (Core Data, NSUserDefaults, NSObject), and then create detail view cells for the table view. The cells are put into groups, and the groups are put into the detail view builder object along with the data manager object.

Please view the demo project (coming soon...) for a detailed example of how to use the library.

