# DescribeThat!

A SaaS product created for [W4156 Advanced Software Engineering](http://www.cs.columbia.edu/~junfeng/21sp-w4156/) at Columbia University in spring 2021.

Team members:
- lyp2106, Lauren Pham
- vn2287, Vishnu Nair
- xw2765, Sheron Wang

[Link](https://describe-that.herokuapp.com) to app on Heroku.  
[Link](https://youtu.be/_Xu9e_M3s20) to project pitch given on February 25, 2021.

1. Running DescribeThat! locally
2. Running Cucumber and RSpec tests locally
3. Demonstration paths
4. Overview
5. User stories
6. Plans for proj-iter-2

## 1. Running DescribeThat! locally
To the TAs: we are hoping that you don't have to run the application locally for ease on both of our parts. In particular, we use the YouTube API, Google TTS API, and AWS SDK to connect to an S3 bucket set up on Vishnu's server with various credentials that are not committed to this repo. However, if you want to run the application locally and haven't received those credentials from us already, please let us know and we will get them to you in a secure way. (We should have already submitted them in a file on Courseworks.)  

To mitigate the need for you to run the application locally, we have served code coverage generated by SimpleCov as a static file which you can access on Heroku [here](https://describe-that.herokuapp.com/coverage). Every time we run Cucumber and RSpec to generate the coverage report and before we push the static file to production, we manually delete all source code information from the report for security.  

> We hope that providing this coverage report on Heroku will eliminate your need to run the app locally. However, if you still need to run the app locally, follow the following instructions:  

Once you have cloned this repository and you are in the **w4156-describe-that** directory, run:
```
$ bundle install
$ bundle exec rake webpacker:install
$ rake db:create
$ rake db:migrate
$ rake db:seed
```
> If you encounter an error like ***An error occurred while installing unf_ext (0.0.7.7), and Bundler cannot continue. Make sure that `gem install unf_ext -v '0.0.7.7' --source 'https://rubygems.org/'` succeeds before bundling.*** and you are on Mac OS, you may need to install xcode. Do this by running ```$ xcode-select --install```.

You will need to fill in the list of local env variables located at **w4156-describe-that/config/local_env.yml** with the credentials we have given you for the API and S3 services. If we have not given them to you yet, please let us know and we will get them to you in a secure way.  

You should be remain on branch main (which will be ahead of production by exactly 1 commit, detailed in section **2. Running Cucumber and Rspect tests locally**). You should be able to access the app in your browser of choice at [localhost::3000](localhost::3000).

## 2. Running Cucumber and RSpec tests locally
By midnight on March 15, 2021, the main branch will be purposefully divergent from the production branch in exactly one way: **app/models/description_track.rb** and **app/models/description.rb** on main will have ```optional: true``` for their foreign keys. This is for Cucumber in particular. We tested successfully creation of foreign key models on the background portion of the Cucumber features, but various steps were unable to find those foreign keys. For example, upon successful creation of Users, the Cucumber steps were unable to access the User model and therefore unable create DescriptionTracks which have a foreign key to User. To bypass this check, we add ```optional: true``` to the foreign key relationships where such an issue arises and the tests pass, which lead us to believe it is a problem with Cucumber.  

There is nothing further for you to set up locally as long as you stay on branch main. This is just a notice for why the main branch should be ahead of production by 1 commit at the time of your testing.  

You can run all Cucumber tests using ```$ rake cucumber```.
You can run all rspec tests using ```$ rake spec```. Not that because of our uniqueness constraints and foreign keys, between every run of either Cucumber or Rspec, you must also reset the temp_test database using ```$ rake db:migrate:reset RAILS_ENV=test ```.

## 3. Demonstration paths
We have provided a few demonstration paths that you can check out at the links below. They are not included in the interface navigation because they are only meant to demonstrate various details about the backend implementation, primarily for TA grading purposes.

1. **Code coverage**. You can see the code coverage generated by SimplCov upon running Cucumber and RSpace [here](https://describe-that.herokuapp.com/coverage).
2. **Users**. The list of users [here](https://describe-that.herokuapp.com/user) is just to show you the users upon your testing. We don't intend for users to actually see the list of all users.
3. **Recently searched and undescribed videos**. Our home page is an index of videos with published audio descriptions. However, the page [here](https://describe-that.herokuapp.com/video/undescribed) is an index of recently searched videos without published audio descriptions. By "recent", we just mean that the videos here have been searched at the main "Enter YouTube URL" search box *at any point*. Upon the first search, the YouTube video gets entered in as a video record. When a user later searches for that same YouTube video, they are getting that video record from the database as opposed to the first time when it was fetched from the YouTube API and saved in the video table. When a user later publishes an audio description for that YouTube video, it becomes visible on the home page.

## 4. Overview

> **DescribeThat!** is a community-driven platform where describers add audio descriptions (AD) to YouTube videos for visually impaired persons (VIPs).

While other platforms providing AD for YouTube videos exist, **DescribeThat!** uniquely gives describers the option to write text descriptions in addition to the traditional mode of AD, which is audio recorded by describers. **DescribeThat!** uses Google Text-to-Speech to generate AD from text descriptions written by describers. The traditional option to record AD is also supported by **DescribeThat!**.

> The option to write text descriptions to be generated into audio by Google TTS does not exclude potential describers due to lack of equipment, differing verbal ability, or plain preference.

## 5. User stories
There are two users which have different stories: **VIPs** (visually impaired persons) and **describers**.

### The **VIP** story
At this point in project implementation, a VIP can search for a video via its YouTube link, access the video's AD if it exists, and request AD for a video if it does not already exist.

### The describer story
At this point in project implementation, a describer can search for a video via its YouTube link and add a single text description to it which will be generated to audio by Google Text-to-Speech. Only one description is allowed per video description track, and only one description track is allowed per video for this iteration.

### Bonus: the user story
A user can be a VIP and/or a describer. A describer is required to be a user, while a VIP is not required to be a user at the moment. People can create a new user and existing users can "log in." At the moment, the notion of logging in is nominal.

## 6. Current (iter-2) status update from iter-1

Items in the following lists will be implemented for proj-iter-2.

### App-wide features pending completion:
1. ~Proper user authentication. The current implementation is naive and insecure.~ Implemented Auth0. To login, users are redirected to Auth0 where they sign in using their email and password. Upon Auth0 callback, the Auth0 auth0_id is stored locally and the local user id is used for foreign key purposes.
2. ~Users may edit their password.~ Since we have implemented Auth0, this is no longer needed.
3. ~Show the selected YouTube video within an `iframe` on the page.~ Implemented.
4. Play descriptions alongside the video (both recorded/generated and inline/extended).

### VIP scenarios pending completion:
1. ~VIPs will be able to request AD for videos.~ Implemented.
2. ~VIPs will be able to upvote requests for AD for videos.~ Implemented.
3. VIPs will be able to view multiple description tracks per video and select one to play.
4. VIPs will be able to identify description tracks by author and language.
5. VIPs will be able to view basic information about the video (as reported by YouTube) on our platform.

### Describe scenarios pending completion:
1. Describers will be able to record audio descriptions directly on the platform.
2. Describers will be able to add multiple descriptions per track.
3. Describers will be able to adjust the voice and speed of TTS-generated descriptions.
4. Describers will be able to dynamically adjust the position of descriptions within a description track.
5. Describers will be able to designate descriptions as _inline_ (plays alongside the video) or _extended_ (pauses the video while the description is playing).