class Post < ActiveRecord::Base

  belongs_to :author

  validate :is_title_case 

  before_validation :make_title_case

  # before_save :make_title_case 

  # The before_save :make_title_case callback above would not save our console test of p = Post.create(title: 'testing')
  # This is because the validate :is_title_case callback fails ('testing' is not title cased)
  # and it stops it from saving into the database. 

  # HERE IS A RULE OF THUMB: 
  # Whenever you are modifying an attribute of the model, use before_validation. 
  # If you are doing some other action, then use before_save.

  # Example of when to use before_save callback would be sending an email to the author 
  # alerting them that the post was just saved whenever the their new post was saved to the database. 

  # Overall, the 4 main callbacks: 
  # 1. validate => some custom code checker to see if true.
  # 2. before_validation => some custom code to turn whatever you're modifying to be true prior to validate callback.
  # 3. before_save => calls on some custom code action right before something new is saved to the database (not updated).
  # 4. before_create => very similar to before_save except this method happens before something is created for the first time.


  private

  def is_title_case
    if title.split.any?{|w|w[0].upcase != w[0]}
      errors.add(:title, "Title must be in title case")
    end
  end

  def make_title_case
    self.title = self.title.titlecase
  end
end
