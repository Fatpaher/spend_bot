[![CircleCI](https://circleci.com/gh/Fatpaher/spend_bot.svg?style=svg)](https://circleci.com/gh/Fatpaher/spend_bot)

####Running the bot

rubn `bundle install` to install required gems

Then you need to create secrets.yml where your bot unique token will be stored and database.yml where database credentials will be stored. I've already created samples for you, so you can easily do:

```
cp config/database.yml.sample config/database.yml
cp config/secrets.yml.sample config/secrets.yml
```

Then you need to fill your Telegram bot unique token to the secrets.yml file and your database credentials to database.yml.

After this you need to create and migrate your database:

```
rake db:create db:migrate
```

To start bot run command

```
bin/bot
```
