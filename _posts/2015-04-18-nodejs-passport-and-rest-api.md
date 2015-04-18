---
layout: post
title: NodeJS passport and why it doesn't fit for REST API
date: April 18th, 2015
keywords: nodejs, passport, strategies, strategy, rest, api
---

I hear many questions in last time like "How to integrate passport strategy into REST API?" or "I have mobile application and NodeJS backend. How can I authorize app at backend?" and so on...

In this post I want to explain, why current passport strategies don't fit to some our requirements when you write authorization layer.

And explanation is simple - current passport strategies, like `passport-facebook`, require views rendering on backend (or any, where OAuth authorization form can show from provider) while we don't have possibility to do that, because we have clean REST API. Without sessions, views and other. Request -> response - that's all.

But we know how fix that. I found the way how we can use passport for authorization layer for RESTful API.

<!--MORE-->

The new flow for authorization is more simple. All authorization flow for getting access_token and refresh_token is going in frontend (mobile app or web app). When frontend app get the access_token from OAuth provider, it can send this access_token to backend. And backend with this token can make request to provider and fetch data.

I wrote a lot passport strategies for this new flow. You can find them in my GitHub repository and install via npm.

Using is very simple. You just install passport strategy and configure it within `passport.use()`.

{% highlight javascript %}
passport.use(new FacebookTokenStrategy(config), function(req, access_token, refresh_token, profile, next) {
    console.log(profile);
});

passport.authenticate('facebook-token', function(error, user, info) {
    console.log('Here is your user model created after social auth' + user);
});

{% endhighlight %}

That's it. In this way you can start using passport and write one authorization layer for all social networks and continue using decoupled mobile apps from backend app.
