# qutcodebot
So this is the offical #qutcode IRC bot.
Currently it will only mirror what you say and tell you how long it has been running.
Future feature will be:
  - retrieve wikipedia links for given keyword (e.g. "qutcodebot search qut")
  - when was the last commit made to the qutcode github repo
  - search programming language keywords/functions (e.g. "qutcodebot java System.out.println")
  - when the next qutcode workshop or meeting is

The bot is written in Haskell and as it is, it is very easy to add new functionality to the code base.
I have quite clearly taken the code from [this example](https://wiki.haskell.org/Roll_your_own_IRC_bot), but this allows those who haven't written/seen/heard of Haskell before to read a good explaination of the code.

Eventually, this bot will be on someones server, always on, but for the moment when I am on #qutcode I will have it on. If anyone wants to test their own version just change the `nick` value and you are good to go.

Enjoy :)
