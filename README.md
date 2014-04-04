RunningRecord
=============

This is a recreation of Ruby on Rails' [Active Record](http://guides.rubyonrails.org/active_record_querying.html), which helped me grock the translation of Active Record methods into SQL queries.

I began with implementing my own my_attr_accessor method, defining setter and getter methods. It was a nice warm up for some of the heavier metaprogramming to be done later. 

The beginning of Active Record involved creating a class, SQLObject, which interacted with the database in a similar manner as ActiveRecord::Base. It would have methods based on the table column headers so that it could know which columns to query, as well as a setter method (using the my_attr_accessor method). Like ActiveRecord::Base, I created methods like ::all, ::find, #insert, etc (all of the necessary CRUD methods).

Next was creating a Searchable module, which allowed a user to find a model based on certain attributes once we extended the class to include the module. 

The final step was making classes associatable. This was one of the more difficult aspects of the project. It was relatively straight forward to include BelongsTo and HasMany associations, but the HasManyThrough association was a little more complicated. The basic idea of the association was to create a define_method method, which would create a new method based on the object that represents the has_many or belongs_to relationship. It is structured as follows:

* Use send to get the value of the foreign key.
* Use model_class to get the target model class.
* Use where to select those models where the primary_key column is equal to the foreign key value.
* Call first (since there should be only one such item).
