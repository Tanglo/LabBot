LabBot
======

The LabBot framework for controlling psychophysical experiments and collecting data.  

The framework is a collection of Objective-C classes written using the Cocoa framework to control various aspects of psychophysical experiments using an Apple computer. Some of the popoular psychophysics frameworks can be slow, unstable, expensive, and awkward to use.  Cocoa applications are not perfect, but I have fdound them flexible and straightforward to use for experimental control.  As it is written for Cocoa, you need only an Apple computer running OS X 10.9 to make use of LabBot.  

LabBot is added to as I find reusable code in my own experimental setups. At this stage it is pre-release because there is not much to it-there are some key pending additions-and because some of the exisiting classes are still in active development. In the future new classes will only be added to the framework after they are proven and, at least in my experience, stable.  

If you find LabBot useful and want to add your own class or tweak and exisiting one please submit a push request so others can benifit.  If you find a short comming or an apparent bug please let me know.

#####Installation#####
Get the latest release binary from https://github.com/Tanglo/LabBot/releases and copy it to where ever you normally put your frameworks (e.g. ~/Library/Frameworks.  Then link to it from Xcode.
