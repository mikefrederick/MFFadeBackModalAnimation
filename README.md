#MFFadeBackModalAnimation

MFFadeBackModalAnimation is a UIViewController category that attempts to mimic the "tilt back" modal presentation animation that can be seen in the Gmail app when composing a new message.

=======

![](http://imgur.com/pbJSi71.png?1)  &nbsp;  ![](http://imgur.com/j1yLJod.png?1)

=======

##Installation

####CocoaPods
Add `pod 'MFFadeBackModalAnimation'` to your Podfile.

####Manually
Add the `UIViewController+MFFadeBackModalAnimation` folder to your project. Add QuartzCore to your project.


##Usage

Presenting a modal view controller:
```objective-c
[self presentViewControllerWithFadebackAnimation:navigationController completion:^{}];
```

Dismissing a modal view controller:
```objective-c
[self dismissViewControllerWithFadebackAnimationCompletion:^{}];