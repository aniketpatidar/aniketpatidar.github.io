---
layout: post
title: "How I contributed notifications to an open-source product"
description: "How I built Moneygun's notification system with the Noticed gem, from installing the gem to sending the first email."
permalink: /how-i-contributed-notifications-to-an-open-source-product/
image: https://cdn.hashnode.com/res/hashnode/image/upload/v1751805807419/b8608399-9201-4f66-ab43-a433def52426.jpeg
tags: opensource, ruby-on-rails, notifications

featured: true
---

In June 2025 I added a notification system to Moneygun, an open-source, white-label SaaS boilerplate for Rails, using the [Noticed](https://github.com/excid3/noticed) gem. It was merged as [PR #286](https://github.com/yshmarov/moneygun/pull/286). This post walks through the setup, from installing the gem to sending the first email.

*Versions at the time: Rails 8.0.2, Ruby 3.4.1, Noticed 2.7.0, Solid Queue 1.1.5, Solid Cable 3.0.8.*

[https://github.com/yshmarov/moneygun/pull/286](https://github.com/yshmarov/moneygun/pull/286)  
## How I found the issue

First, I want to share that I learned about [Yaroslav Shmarov](https://x.com/yarotheslav) (@yarotheslav) looking for contributors for their open-source product, Moneygun, through a Twitter post he made. I also wanted to explore the new version of the Noticed gem, so I decided to give it a try. That's how I got the opportunity to work on this [issue](https://github.com/yshmarov/moneygun/issues/285).

Do check out Moneygun if you want to build your next B2B SaaS app (software as a service): [https://github.com/yshmarov/moneygun](https://github.com/yshmarov/moneygun)

[![Yaroslav Shmarov's post on X inviting contributors to Moneygun](https://cdn.hashnode.com/res/hashnode/image/upload/v1751806188505/251884e9-cc45-4543-a204-0a066a36b808.png)](https://x.com/yarotheslav/status/1934196524633706540)

There are two things that need to be implemented. 

* In-app notifications
    
* Email
    

## Installing Noticed

First, I explored the gem to understand how to implement basic boilerplate code for notifications, then began by adding the gem to the Rails application:

```ruby
# notifications
gem "noticed"
```

Or

Run the following command to add Noticed to your Gemfile:

```bash
bundle add "noticed"
```

Generate and then run the migrations:

```bash
rails noticed:install:migrations
rails db:migrate
```

## Creating the notifiers

To start, create a Notifier:

We have two requirements here:

1. The user should be notified when they are invited to an organization.
    
2. The user should be notified when their membership request is accepted.
    

```bash
rails generate noticed:notifier MembershipInvitationNotifier
rails generate noticed:notifier MembershipRequestAcceptedNotifier
```

This post covers email delivery.

Here's what the generator created.

Three files are created under the notifiers:

```ruby
# app/notifiers/application_notifier.rb
class ApplicationNotifier < Noticed::Event
end
```

```ruby
# app/notifiers/membership_request_accepted_notifier.rb
# To deliver this notification:
#
# MembershipRequestAcceptedNotifier.with(record: @post, message: "New post").deliver(User.all)
class MembershipRequestAcceptedNotifier < ApplicationNotifier
 # Add your delivery methods
 #
 # deliver_by :email do |config|
 #   config.mailer = "UserMailer"
 #   config.method = "new_post"
 # end
 #
 # bulk_deliver_by :slack do |config|
 #   config.url = -> { Rails.application.credentials.slack_webhook_url }
 # end
 #
 # deliver_by :custom do |config|
 #   config.class = "MyDeliveryMethod"
 # end
 #
 # Add required params
 #
 # required_param :message
end
```

```ruby
# app/notifiers/membership_invitation_notifier.rb
# To deliver this notification:
#
# MembershipInvitationNotifier.with(record: @post, message: "New post").deliver(User.all)
class MembershipInvitationNotifier < ApplicationNotifier
 # Add your delivery methods
 #
 # deliver_by :email do |config|
 #   config.mailer = "UserMailer"
 #   config.method = "new_post"
 # end
 #
 # bulk_deliver_by :slack do |config|
 #   config.url = -> { Rails.application.credentials.slack_webhook_url }
 # end
 #
 # deliver_by :custom do |config|
 #   config.class = "MyDeliveryMethod"
 # end
 #
 # Add required params
 #
 # required_param :message
end
```

## Delivering by email

In the boilerplate code, you can see there's `deliver_by :email`, so I implemented the mailer delivery method first.

I'll walk through one notifier here. The other two follow the same pattern.

The first one notifies a user when they're invited to an organization. First, clean up the commented lines and keep only the ones that are needed.

```ruby
class MembershipInvitationNotifier < ApplicationNotifier
 # Add your delivery methods
 #
 # deliver_by :email do |config|
 #   config.mailer = "UserMailer"
 #   config.method = "new_post"
 # end
 #
 # Add required params
 #
 # required_param :message
end
```

Notifiers can use different helper methods. Inside a notification\_methods block, I also set up the message and URL helpers.

```ruby
notification_methods do
   # I18n helpers
   def message
     t(".message")
   end

   # URL helpers are accessible in notifications
   # Don't forget to set your default_url_options so Rails knows how to generate urls
   def url
     user_invitations_url
   end
 end
```

These helpers can be helpful when rendering a user’s notifications on the web.

```erb
<div>
  <% @user.notifications.each do |notification| %>
    <%= link_to notification.message, notification.url %>
  <% end %>
</div>
```

Calling the message helper in the ERB view will look for the following translation path:

```yaml
# config/locales/en.yml
en:
 notifiers:
   membership_invitation_notifier:
     notification:
       message: You've been invited to join %{organization_name}
```

Notifiers can choose required parameters using the `required_params` method. I declared `:organization` as a required parameter, so `params[:organization]` is always available in the notifier:

```ruby
 required_params :organization
```

```ruby
 def message
   t(".message", organization_name: params[:organization].name)
 end
```

In this case, we need the mailer, so generate it by running

```bash
rails generate mailer MembershipMailer invitation_email
```

```ruby
# app/mailers/membership_mailer.rb
class MembershipMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.membership_mailer.invitation_email.subject
  #
  def invitation_email
    @greeting = "Hi"
    mail to: "to@example.org"
  end
end
```

app/views/membership\_mailer/invitation\_email.text.erb

```erb
Membership#invitation_email

<%= @greeting %>, find me in app/views/membership_mailer/invitation_email.text.erb
```

Instead of this default greeting, I wanted to send the notification's message and include the action\_url. To do this, we need to have the notification object available, so we should pass it from our notifier like this:

```ruby
deliver_by :email do |config|
  config.mailer = "MembershipMailer"
  config.method = :invitation_email
  config.args   = -> { [ self ] }
end
```

That needs a small change to the mailer method.

```ruby
# app/mailers/membership_mailer.rb
class MembershipMailer < ApplicationMailer
  def invitation_email(notification)
    setup(notification)
    mail(to: @recipient.email, subject: t(".subject", organization_name: @organization.name))
  end

  private

  def setup(notification)
    @organization = notification.params[:organization]
    @message = notification.message
    @recipient = notification.recipient
    @action_url = notification.url
  end
end
```

```erb
# app/views/membership_mailer/invitation_email.text.erb
<%= @message %>

View your invitations: <%= @action_url %>
```

Now our notifier code looks like this:

```ruby
class MembershipInvitationNotifier < ApplicationNotifier
  # Add your delivery methods
  deliver_by :email do |config|
    config.mailer = "MembershipMailer"
    config.method = :invitation_email
    config.args   = -> { [ self ] }
  end

  # Add required params
  required_params :organization

  notification_methods do
    # I18n helpers
    def message
      t(".message", organization_name: params[:organization].name)
    end

    # URL helpers are accessible in notifications
    # Don't forget to set your default_url_options so Rails knows how to generate urls
    def url
      user_invitations_url
    end
  end
end
```

## Triggering the notification

That completes the notifier. Next, we need to trigger this notifier:

```ruby
# app/models/membership.rb
class Membership < ApplicationRecord
  after_create :send_invitation_notification

  private

  def send_invitation_notification
    MembershipInvitationNotifier.with(organization: organization).deliver(user)
  end
end
```

With this setup in place, a user gets an email when they're invited to join an organization.

The PR also covers the other two notifiers and live in-app updates through a custom Turbo Stream delivery method. Getting those live updates working in development took the longest: the cause was Action Cable's `async` adapter, not my code. I wrote up that part, and the full list of what the PR changed, on [the contribution page](/contributions/full-in-app-notification-system-using-the-noticed-gem/).
