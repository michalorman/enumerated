# Enumerated - yet another enumeration gem for ActiveRecord

Ok, there are few gems that provides enumeration support to Rails ActiveRecord models, but still missing some
features. The goal of the **Enumerated** gem is not to provide the feature richest enumeration support, but to make it
useful to use together with selection/drop down lists. So if you need advanced support consider usage of other
gem, however if you simply need to work with selection lists this gem is for you.

The **Enumerated** gem will provide support to translate enumerated attributes into labels that are shown in
selection lists on view and into keys which are stored in the database. This decouples the values stored in
database and those presented to user on view, so you can freely change labels and no database changes are
required. **I18n** is supported by default.

The enumerated attribute keys are stored in database as strings. If you want to modify enumeration's key simply
write the migration that will rename appropriate rows. Changing the label doesn't require any modifications
in database.

## Installation

Add to your Gemfile:

    gem 'enumerated'

## Usage

First you need to define your attributes that will be enumerated:

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

If labels are not explicitly defined the humanized versions are taken by default. Labels defined
in ``Hash`` will override those defined in localization file.

## Advanced usage

By default the order of enumeration options returned by the helper methods is unspecified (albeit most probably
it will match the order of declaration). If you need to define certain order of the labels (eg. on selection list)
use the ``:order`` parameter:

    User.genders :order => [ :female, :male ]       # => [["Female", :female], ["Male", :male]]
    user_genders :order => [ :female, :male ]       # => [["Female", :female], ["Male", :male]]

You can also provide alphabetical order:

    User.genders :order => :alphabetical        # => [["Female", :female], ["Male", :male]]

Also you can define which enumeration options you want to method return:

    User.genders :except => [:male]     # => [["Female", :female]]
    User.genders :only => [:female]     # => [["Female", :female]]

Labels might be overridden:

    User.genders :override => { :male => "Sir" }    # => [["Sir", :male], ["Female", :female]]

*Note that all parameters shown in this section also applies to method defined in helper module.*

## Validation

By default the ``enumerated`` declaration will add the validation for inclusion of the values specified
in the declaration. It means that by default model won't be valid if enumerated attribute will have value
other than specified in the ``enumerated`` declaration:

    class User < ActiveRecord::Base
        enumerated :gender, [:male, :female]
        # Implicitly adds the following:
        validates :gender, :inclusion => [nil, :male, :female]
    end

If you want to prevent **Enumerated** gem adding the validation type:

    class User < ActiveRecord::Base
        enumerated :gender, [:male, :female], :validate => false
    end

By default **Enumerated** will add ``nil`` value to the array of expected values (in inclusion statement).
If you do not want to include ``nil`` type:

    class User < ActiveRecord::Base
        enumerated :gender, [:male, :female], :nillable => false
    end

## Issues

    * Currently not supporting STI