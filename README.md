# [NOVA Book and Wine Club](http://www.novabookandwineclub.com)

A Ruby on Rails app for my book club. The app lets users add books to the group bookshelf, schedule meetings, post pictures of meetings, and take notes for books they are reading.

The app is run on Elasticbeanstalk and hosted by Amazon Web Services.

![welcome screenshot](https://github.com/SamuelLangenfeld/book_club/blob/master/app/assets/images/welcome_screenshot.png?raw=true)

## Walkthrough

Currently users must register to create, but their email addresses are not confirmed. Anyone who is not signed in can only see the club's bookshelf. Registered users have access to the bookshelf and can see other users in the group and can create and edit group content and private notes.

The bookshelf is where users can see all of the books the group has read or is currently reading.

![bookshelf screenshot](https://github.com/SamuelLangenfeld/book_club/blob/master/app/assets/images/bookshelf_screenshot.png?raw=true)

From the bookshelf users can select a book to view. The book's page shows the user the title, author, the group meeting, pictures from the meeting, and the users private notes on the book. The user can edit or create any of these attributes.

![add meeting screenshot](https://github.com/SamuelLangenfeld/book_club/blob/master/app/assets/images/add_meeting_screenshot.png?raw=true)

![add picture and notes screenshot](https://github.com/SamuelLangenfeld/book_club/blob/master/app/assets/images/picture_and_notes_screenshot.png?raw=true)


## Built With
* [Ruby on Rails](http://rubyonrails.org/)
* [Bootstrap](http://getbootstrap.com/)
* [Devise](http://devise.plataformatec.com.br/)
* [CarrierWave](https://github.com/carrierwaveuploader/carrierwave)
* [Figaro](https://github.com/laserlemon/figaro)

## Testing With
* [RSpec](http://rspec.info/)
* [SimpleCov](https://github.com/colszowka/simplecov)


## Future Functions
Let users add wines we've sampled.
Implement rating system for books and wines.
Sidebar for easy navigation on large pages.
Implement email for app to confirm users on registration and send club updates.