## EconTalk Downloader

This is a small common lisp utility program that downloads the entire catalog of [econtalk](https://www.econtalk.org/) episodes.

All episodes are downloaded to ~/econtalk-downloads/. The utility checks for their existence before downloading, so the user can run this program as a daemon, downloading the updated catalog each week.
