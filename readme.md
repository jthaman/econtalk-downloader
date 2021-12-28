## EconTalk Downloader

This is a small common lisp utility program that downloads the entire catalog of [econtalk](https://www.econtalk.org/) episodes.

All episodes are downloaded to ~/econtalk-downloads/. The utility checks for their existence before downloading, so the user can run this program as a daemon, downloading the updated catalog each week.

Tested with SBCL and requires Quicklisp.

## How to run

First, install sbcl and Quicklisp, then

```
git clone https://github.com/jthaman/econtalk-downloader.git
cd econtalk-downloader
sbcl --script econtalk-downloader.lisp
```
