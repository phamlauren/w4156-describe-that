# DescribeThat!

A SaaS product created for [W4156 Advanced Software Engineering](http://www.cs.columbia.edu/~junfeng/21sp-w4156/) at Columbia University in spring 2021.

Team members:
lyp2106, Lauren Pham
vn2287, Vishnu Nair
xw2765, Sheron Wang

[Link](https://describe-that.herokuapp.com) to app on Heroku.
[Link](https://youtu.be/_Xu9e_M3s20) to project pitch given on February 25, 2021.

1. Run DescribeThat! locally
2. Overview
3. User stories
4. Details for proj-iter-1
5. Plans for proj-iter-2

## 1. Run DescribeThat! locally
Once you have cloned this repository and you are in the **w4156-describe-that** directory, run:
```
$ bundle install
$ bundle exec rake webpacker:install
$ rake db:create
$ rake: db:migrate
```
You should be able to access the app in your browser of choice at [localhost::3000](localhost::3000).

## 2. Overview

> **DescribeThat!** is a community-driven platform where describers add audio descriptions (AD) to YouTube videos for visually impaired persons (VIPs).

While other platforms providing AD for YouTube videos exist, **DescribeThat!** uniquely gives describers the option to write text descriptions in addition to the traditional mode of AD, which is audio recorded by describers. **DescribeThat!** uses Google Text-to-Speech to generate AD from text descriptions written by describers. The traditional option to record AD is also supported by **DescribeThat!**.

> The option to write text descriptions to be generated into audio by Google TTS does not exclude potential describers due to lack of equipment, differing verbal ability, or plain preference.

## 3. User stories
There are two users which have different stories: **viewers** and **describers**

### The viewer story

### The describer story

## 4. Details for proj-iter-1

The **SimpleCov** gem reports that our cucumber tests cover __% and that our RSpec tests cover __% of our code.

## 5. Plans for proj-iter-2

Items in the following lists will be implemented for proj-iter-2.

### App-wide features pending completion:
1. Proper user authentication. The current implementation is naive and insecure.
2. Google TTS. The current implementation allows for text descriptions to be saved, but audio is yet to be generated via Google TTS.
3. 

### Viewer scenarios pending completion:

### Describe scenarios pending completion:
