# Spree on Heroku

This is an extension for Spree, allowing the e-commerce system to run on Heroku - http://heroku.com.

The major constraint on Heroku is that we can't write files to disk, so this extension disables all disk caching, fixes a few issues and changes Spree to store on Amazon S3.

# Requirements 

A Heroku account and an Amazon S3 account with a bucket.

# Installation and configuration

Make a Spree application:

<pre>
spree myapp
</pre>

Install this extension:

<pre>
script/extension install git://github.com/RSpace/spree-heroku.git
</pre>

Copy the .gems manifest to the root of your application:

<pre>
cp vendor/extensions/heroku/.gems ./
</pre>

Create a Heroku application and deploy it:

<pre>
git init
git add .
git commit -m 'Initial create'
heroku create myapp
git push heroku master
</pre>

Bootstrap the database locally (not possible in Heroku, because the rake task attempts to copy files), and transfer it to Heroku:

<pre>
rake db:bootstrap
heroku db:push
</pre>

Configure the extension with your S3 information and restart the application on Heroku:

<pre>
heroku console
>> Spree::Heroku::Config.set(:bucket => 'bucket name')
>> Spree::Heroku::Config.set(:access_key_id => 'access key')
>> Spree::Heroku::Config.set(:secret_access_key => 'secret access key')
heroku restart
</pre>

That's it - you're done! :)


# Thanks to 

Mooktakim Ahmed for creating the HerokuSassAndCache plugin, which is bundled with this extension.