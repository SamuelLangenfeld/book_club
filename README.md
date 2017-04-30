# Book Club App

A simple rails app for my book club. I want the app to show scheduled meetings, what books we've chosen, and allow users to take private notes and have public discussions. In progress.

For deploying apps-
CarrierWave required ENV variables to be set up in order to use the gem. So this is the first time I've consciously done that. Environment variables apparently have nothing to do with rails and operate at a lower level. 

the commands to set elastic beanstalk env variables are as such:
eb setenv key:"name"
I had to set key id, access id, and bucket for aws