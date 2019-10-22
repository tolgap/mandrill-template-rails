# MandrillRails
Send emails using Mandrill Templates and ActionMailer.

## Usage
Create an initializer to setup your API key and optional debug option:

```ruby
# config/initializers/mandrill_rails

MandrillRails.configure do |config|
  config.api_key = ENV['MANDRILL_API_KEY']
  config.debug = false
end
```

Inherit from `MandrillRails::TemplateMailer` for your own Mailers:

```ruby
class UserMailer < MandrillRails::TemplateMailer
  def welcome(user_id)
    user = User.find(user_id)

    mail(to: user.email, cc: user.carbon_copy_email) do |message|
      message.mandrill_template 'my-mandrill-template-slug'
      message.mandrill_merge_vars(
        FIRST_NAME: user.first_name,
        LAST_NAME: user.last_name,
        ACTIVATED_AT: Date.today.to_s
      )
    end
  end
end
```

This will send the following API request to Mandrill Messages API:

```
https://mandrillapp.com/api/1.0/messages/send-template.json

{
  "key": "your configured api key in the initializer",
  "template_name": "my-mandrill-template-slug",
  "template_content": [],
  "message": {
    "to": [
      {
        "email": "user@email.com",
        "type": "to"
      }
    ],
    "global_merge_vars": [
      {
        "FIRST_NAME": "user first_name",
        "LAST_NAME": "user last_name",
        "ACTIVATED_AT": "yyyy-mm-dd"
      }
    ]
  }
}
```

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'mandrill_rails'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install mandrill_rails
```

## Contributing

1. Only `global_merge_vars` are supported for now, so only individual emails are supported.
2. No support for attachments
3. No support for template content

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
