# Enumerator - yet another enumeration gem for Rails

Ok, there are few gems that provides enumeration support to Rails ActiveRecord models, but still missing some
features. The goal of the **Enumerator** gem is not to provide the feature richest enumeration support, but to make it
useful to use together with selection/drop down lists. So if you need advanced support consider usage of other
gem, however if you simply need to work with selection lists this gem is for you.

## Installation

    gem 'enumerator'

## Usage

First you need to declare your enumerated attributes in the migration:

    create_table :users do |t|
        t.string :gender
    end

Next you need to define your enumerations in the model class:

    class User < ActiveRecord::Base
        enumerated :gender, [ :male, :female ]
    end

Enumerated attributes are the values that will be stored in the database (as string).

Having declared enumeration you gain access to several methods. At first you can list
all available enumeration values:

    User.genders        # => [["Male", :male], ["Female", :female]]

Views and controllers will also have access to helper method:

    user_genders        # => [["Male", :male], ["Female", :female]]

By default this helper method will be added to the controller corresponding to the model,
so in case of ``User`` model the ``user_genders`` method will be added to ``UsersHelper``.
If you want to declare other module use ``:helper`` parameter in the declaration:

    class User < ActiveRecord::Base
        enumerated :gender, [ :male, :female ], :helper => ApplicationHelper
    end

If you do not want the helper method at all use:

    class User < ActiveRecord::Base
        enumerated :gender, [ :male, :female ], :helper => false
    end

### Applying and reading enumeration

There are several ways to set and get the value of enumerated attribute:

    user = User.new
    user.gender = :male
    user.gender             # => :male
    user.male?              # => true
    user.female?            # => false
    user.gender_label       # => "Male"
    user.female!            # => :female
    user.gender_label       # => "Female"

### Labels and I18n

Enumeration labels may be defined in two ways. First is the place where the enumeration is
declared:

    class User < ActiveRecord::Base
        enumerated :gender, { :male => "Sir", :female => "Madam" }
    end

Second, and more preferred way is the localization file:

    en:
      activerecord:
        enumerations:
          user:
            gender:
              male: "Sir"
              female: "Madam"

If labels are not explicitly defined the humanized versions are taken by default.

## Advanced usage

By default the order of enumeration options returned by the helper methods is unspecified. If
you need to define certain order of the labels (eg. on selection list) use the ``:order`` parameter:

    User.genders :order => [ :female, :male ]       # => [["Female", :female], ["Male", :male]]
    user_genders :order => [ :female, :male ]       # => [["Female", :female], ["Male", :male]]

You can also provide alphabetical order:

    User.genders :order => :alphabetical        # => [["Female", :female], ["Male", :male]]

Also you can define which enumeration options you want to method return:

    User.genders :except => [:male]     # [["Female", :female]]
    User.genders :only => [:female]     # [["Female", :female]]

