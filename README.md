# DescribeThat!

A SaaS product created for [W4156 Advanced Software Engineering](http://www.cs.columbia.edu/~junfeng/21sp-w4156/) at Columbia University in spring 2021.

Team members:

- lyp2106, Lauren Pham
- vn2287, Vishnu Nair
- xw2765, Sheron Wang

[Link](https://describe-that.herokuapp.com) to iteration 1 on Heroku.  
[Link](https://w4156.herokuapp.com) to iteration 2 on Heroku.  
[Link](https://youtu.be/_Xu9e_M3s20) to project pitch given on February 25, 2021.

1. Overview
2. User stories
3. Current (iter-2) status update from iter-1
4. Plans for final iteration
5. Running DescribeThat! locally
6. Running Cucumber and RSpec tests locally
7. Demonstration paths

## 1. Overview

> **DescribeThat!** is a community-driven platform where describers add audio descriptions (AD) to YouTube videos for visually impaired persons (VIPs).

While other platforms that provide users the ability to add AD for YouTube videos exist, **DescribeThat!** uniquely gives describers the option to write text descriptions in addition to the traditional mode of recording spoken AD. **DescribeThat!** uses Google Text-To-Speech to generate AD from these text descriptions written by describers. The traditional option to record AD is also supported by **DescribeThat!**.

> The option to write text descriptions to be generated into audio by Google TTS is uniquely inclusive to potential describers who otherwise would not contribute AD due to lack of equipment, differing verbal ability, or plain preference.

**DescribeThat!** depends on **Auth0**, **YouTube API**, and **Google TTS API**, and **AWS SDK** to connect to an **S3 bucket** set up on Vishnu's personal server.

## 2. User stories

There are two users which have different stories: **VIPs** (visually impaired persons) and **describers**.

### The **VIP** story

At this point in project implementation, a VIP can search for a video via its YouTube link, access the video's various AD if they exist, and request or upvote another user's request for AD for a specific video. The user can also click on a video on the home page, which is a list of videos that already have at least one AD track. The user can request AD for the video in multiple languages.

### The describer story

At this point in project implementation, a describer can search for a video via its YouTube link, select a language in which to describe, and add multiple descriptions. Each description can either be recorded or written, the latter which will be generated to audio by Google Text-To-Speech. Each description can be designated inline, which means that it will play on top of the original video audio, or extended, which means that the video will pause while the AD is being played. A video can have multiple AD tracks and in multiple languages.

### The user story

A user can be a VIP and/or a describer. A describer is required to be a user, while a VIP is not required to be a user unless they want to request AD or upvote a request. **Describe-That!** depends on **Auth0**, so users are redirected to **Auth0**'s login page to login. Upon first login, the user is stored in a local user database and the username becomes **Auth0**'s default username, which is the username before the domain name of the email they use to log into **Auth0**. When a user is logged in, they can see their dashboard, which includes all of the AD tracks they've written, all of the videos for which they have requested or upvoted a request for AD and in which languages, and all of their comments.

## 3. Current (iter-2) status update from iter-1

The following lists were written upon submission of iteration 1 as features to be implemented by iteration 2.

### App-wide features pending completion:

1. ~Proper user authentication. The current implementation is naive and insecure.~ **Implemented Auth0. To login, users are redirected to Auth0 where they sign in using their email and password. Upon Auth0 callback, the Auth0 auth0_id is stored locally and the local user id is used for foreign key purposes.**
2. ~Users may edit their password.~ **Since we have implemented Auth0, this is no longer needed.**
3. ~Show the selected YouTube video within an `iframe` on the page.~ **Implemented.**
4. ~Play descriptions alongside the video (both recorded/generated and inline/extended).~ **Implemented.**

### VIP scenarios pending completion:

1. ~VIPs will be able to request AD for videos.~ **Implemented.**
2. ~VIPs will be able to upvote requests for AD for videos.~ **Implemented.**
3. ~VIPs will be able to view multiple description tracks per video and select one to play.~ **Implemented.**
4. ~VIPs will be able to identify description tracks by author and language.~ **Implemented.**
5. ~VIPs will be able to view basic information about the video (as reported by YouTube) on our platform.~ **Implemented.**

### Describe scenarios pending completion:

1. ~Describers will be able to record audio descriptions directly on the platform.~ **Implemented.**
2. ~Describers will be able to add multiple descriptions per track.~ **Implemented.**
3. ~Describers will be able to adjust the voice and speed of TTS-generated descriptions.~ **Implemented.**
4. ~Describers will be able to dynamically adjust the timing of descriptions within a description track.~ **Implemented.**
5. ~Describers will be able to designate descriptions as _inline_ (plays alongside the video) or _extended_ (pauses the video while the description is playing).~ **Implemented.**

## 4. Plans for final iteration

As seen in the previous section, we implemented everything that we had planned at the end of iteration 1 for iteration 2. Here follows a list of final items to implement:

1. Allow users to favorite AD tracks, which will then show up on their dashboard.
2. Allow custom volume management for AD and original video audio.
3. Allow users to upvote AD tracks.
4. Allow users to add comments and comment replies to AD tracks.
5. Allow users to edit their username.
6. Implement the notion of "fulfilled" and "unfulfilled" requests, so that if a user publishes AD for a request in the requested language, then the requests are marked as "fulfilled"; if AD for that language has yet to be published or if AD for that language becomes unpublished, then the requests are marked as "unfulfilled."
7. Validate descriptions so that there are no descriptions that overlap at any time.
8. Optimize interface for screen readers.

## 5. Running DescribeThat! locally

To the TAs: we are hoping that you don't have to run the application locally for ease on both of our parts. However, if you want to run the application locally and haven't received API credentials from us already, please let us know and we will get them to you in a secure way. (We should have already submitted them in a file on Courseworks.)

To mitigate the need for you to run the application locally, we have served code coverage generated by SimpleCov as a static file which you can access on Heroku [here for iter-2](https://w4156.herokuapp.com/coverage). Every time we run Cucumber and RSpec to generate the coverage report and before we push the static file to production, we manually delete all source code information from the report for security. As of midnight on 29 March 2021, this static file will have the code coverage generated by running Cucumber and RSpec on the source code submitted for the iteration 2 deadline.

> We hope that providing this coverage report on Heroku will eliminate your need to run the app locally. However, if you still need to run the app locally, follow the following instructions:

Once you have cloned this repository and you are in the `w4156-describe-that` directory, run:

```
$ bundle install
$ bundle exec rake webpacker:install
$ rake db:create
$ rake db:migrate
$ rake db:seed
```

> If you encounter an error like **_An error occurred while installing unf_ext (0.0.7.7), and Bundler cannot continue. Make sure that `gem install unf_ext -v '0.0.7.7' --source 'https://rubygems.org/'` succeeds before bundling._** and you are on Mac OS, you may need to install xcode. Do this by running `$ xcode-select --install`.

You will need to fill in the list of local env variables located at `w4156-describe-that/config/local_env.yml` with the credentials we have given you for the API and S3 services. If we have not given them to you yet, please let us know and we will get them to you in a secure way.

You should be remain on branch main. You should be able to access the app in your browser of choice at [localhost::3000](localhost::3000).

## 6. Running Cucumber and RSpec tests locally

As we are testing some features related to Javascript, we enabled the Selenium driver in Capybara, and thus the **Firefox browser** is needed. Please install Firefox and get all credentials before running the Cucumber tests. When Cucumber encounters its first Javascript scenario, Firefox will be opened by the terminal and run the scenario automatically.  

Additionally, **sometimes the steps fail because the components rendered by Javascript haven't been created by the time Cucumber does the checking**. We have run the tests several times and all steps pass when the response time is under the maximum wait time we have specified, which is 60 seconds. We expect all steps to eventually pass given enough time, so you can rerun the Cucumber tests until all of them pass. You could also increase the max wait time in `features/support/env.rb` (line 48) which is already 60 seconds and try again. During our final run of the tests before submitting iteration 2, we logged the program outputs of ```rake cucumber``` and ```rake spec``` to two files in the root directory: `rake_cucumber_results` and `rake_spec_results`, so you can also see our expected output there.  

You can run all Cucumber tests using `$ rake cucumber`.
You can run all rspec tests using `$ rake spec`. Note that because of our uniqueness constraints and foreign keys, between every run of either Cucumber or Rspec, you must also reset the temp_test database using `$ rake db:migrate:reset RAILS_ENV=temp_test `.

## 7. Demonstration paths

We have provided a few demonstration paths that you can check out at the links below. They are not included in the interface navigation because they are only meant to demonstrate various details about the backend implementation, primarily for TA grading purposes.

1. **Code coverage**. You can see the code coverage generated by SimplCov upon running Cucumber and RSpace [here](https://w4156.herokuapp.com/coverage).
2. **Users**. The list of users [here](https://w4156.herokuapp.com/user) is just to show you the users upon your testing. We don't intend for users to actually see the list of all users.
3. **Recently searched and undescribed videos**. Our home page is an index of videos with published audio descriptions. However, the page [here](https://w4156.herokuapp.com/video/undescribed) is an index of recently searched videos without published audio descriptions. By "recent", we just mean that the videos here have been searched at the main "Enter YouTube URL" search box _at any point_. Upon the first search, the YouTube video gets entered in as a video record. When a user later searches for that same YouTube video, they are getting that video record from the database as opposed to the first time when it was fetched from the YouTube API and saved in the video table. When a user later publishes an audio description for that YouTube video, it becomes visible on the home page.
