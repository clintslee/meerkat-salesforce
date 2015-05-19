# Meerkat API Client for Salesforce

This is a Meerkat REST API wrapper built for the Force.com platform.

With this library you can:

* Make requests to Meerkat's [REST API](http://developers.meerkatapp.co/api)
* Get a list of all current and upcoming broadcasts
* Find broadcast stats like comments, restreams, and likes
* Get a user's details including a list of followers and following

Installation
==========

If you're installing this library for the first time just install using this unmanaged package: <https://login.salesforce.com/packaging/installPackage.apexp?p0=04t1a0000009kNv>


Getting Started
==========

You will need a Meerkat API Key to make begin making requests.  You can apply for one [here](https://docs.google.com/a/meerkatapp.co/forms/d/1B-6gFyMTP_29bj10ogmlciWWMH1xQFWVI3LeYSDeZbM/viewform).

Below are examples of how to use the Meerkat Rest Client.

Get all Broadcasts
-----------
This sample retrieves a list of all the current live and scheduled broadcasts. 

```javascript
String apiKey = 'XXXXXXXXXXXXXXXXX';

MeerkatRestClient client = MeerkatAPI.createClient(apiKey);

MeerkatBroadcastList broadcasts = client.getBroadcasts();

for(MeerkatBroadcast bc : broadcasts.getPageData())
{
    System.debug('Broadcast Id: ' + bc.getId());
    System.debug('Url: ' + bc.getUrl());
}
```

Get a Broadcast
-----------
This sample gets a single broadcast when the broadcast id is known.

```javascript
String apiKey = 'XXXXXXXXXXXXXXXXX';
String broadcastId = '12121212121212';

MeerkatRestClient client = MeerkatAPI.createClient(apiKey);

MeerkatBroadcast broadcast = client.getBroadcast(broadcastId);
```

Get a Broadcast Summary
-----------
This sample gets an in-depth summary of one broadcast.

```javascript
String apiKey = 'XXXXXXXXXXXXXXXXX';

MeerkatRestClient client = MeerkatAPI.createClient(apiKey);

MeerkatBroadcast bc = client.getBroadcasts().getPageData().get(0);  // get the first broadcast on the list
MeerkatBroadcastSummary summary = bc.getSummary();

System.debug('Caption: ' + summary.getCaption());
System.debug('Status: ' + summary.getStatus());
System.debug('# of Watchers: ' + summary.getWatchersCount());
System.debug('# of Comments: ' + summary.getCommentsCount());
System.debug('# of Likes: ' + summary.getLikesCount());
```

Get a list of Comments
--------------

This sample gets a list of comments for a broadcast.

```javascript
String apiKey = 'XXXXXXXXXXXXXXXXX';

MeerkatRestClient client = MeerkatAPI.createClient(apiKey);

MeerkatBroadcast bc = client.getBroadcasts().getPageData().get(0);
MeerkatCommentList comments = bc.getComments();

for(MeerkatComment comment : comments)
{
    System.debug('Watcher: ' + summary.getWatcher());
    System.debug('Title: ' + summary.getTitle());
    System.debug('Message: ' + summary.getMessage());
}
```

Get a list of Likes
---------------

This sample gets a list of likes for a broadcast.

```javascript
String apiKey = 'XXXXXXXXXXXXXXXXX';

MeerkatRestClient client = MeerkatAPI.createClient(apiKey);

MeerkatBroadcast bc = client.getBroadcasts().getPageData().get(0);
MeerkatLikeList likes = bc.getLikes();

for(MeerkatLike l : likes)
{
    System.debug('Watcher: ' + l.getWatcher());
    System.debug('Title: ' + l.getTitle());
    System.debug('Message: ' + l.getMessage());
}
```

Get a list of Restreams
---------------

This sample gets a list of likes for a broadcast.

```javascript
String apiKey = 'XXXXXXXXXXXXXXXXX';

MeerkatRestClient client = MeerkatAPI.createClient(apiKey);

MeerkatBroadcast bc = client.getBroadcasts().getPageData().get(0);
MeerkatRestreamList likes = bc.getRestreams();

for(MeerkatRestream restream : restreams)
{
    System.debug('Watcher: ' + restream.getWatcher());
    System.debug('Title: ' + restream.getTitle());
    System.debug('Message: ' + restream.getMessage());
}
```

Get a list of Watchers
---------------

This sample gets a list of people (watchers) who watched a broadcast.

```javascript
String apiKey = 'XXXXXXXXXXXXXXXXX';
String broadcastId = '121212121212';

MeerkatRestClient client = MeerkatAPI.createClient(apiKey);

MeerkatBroadcast bc = client.getBroadcast(broadcastId);
MeerkatWatcherList watchers = bc.getWatchers();

for(MeerkatWatcher watcher : watchers)
{
    System.debug('Watcher Id: ' + watcher.getId());
    System.debug('Username: ' + watcher.getUsername());
    System.debug('Display Name: ' + watcher.getDisplayName());
}
```

Get a User
-------------

This sample gets a user's details.

```javascript
String apiKey = 'XXXXXXXXXXXXXXXXX';
String userId = '112358132134';

MeerkatRestClient client = MeerkatAPI.createClient(apiKey);

MeerkatUser user = client.getUser(userId);

System.debug('Username: ' + user.getUsername());
System.debug('Score: ' + user.getScore());
```

Get a User's Followers and Following
-------------

This sample gets a user's details.

```javascript
String apiKey = 'XXXXXXXXXXXXXXXXX';
String userId = '112358132134';

MeerkatRestClient client = MeerkatAPI.createClient(apiKey);

MeerkatUser user = client.getUser(userId);

MeerkatFollowerList followers = user.getFollowers();
MeerkatFollowingList following = user.getFollowing();

// print followers
for(MeerkatUser user : followers.getPageData())
{
    System.debug('Username: ' + user.getUsername());
    System.debug('Score: ' + user.getScore());
}

// print following
for(MeerkatUser user : following.getPageData())
{
    System.debug('Username: ' + user.getUsername());
    System.debug('Score: ' + user.getScore());
}
```

Attribution
==========

The framework/structure of the [Twilio-Salesforce Library](https://github.com/twilio/twilio-salesforce) was heavily leveraged to build this library.  Hats off to [John Sheehan](https://github.com/johnsheehan), [Jon Plax](https://github.com/spaceman1066) and all the other contributors for building that great library.