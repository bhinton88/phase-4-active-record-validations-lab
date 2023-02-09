class Post < ApplicationRecord

  validates :title, presence: true
  validates :content, length: { minimum: 250 }
  validates :summary, length: { maximum: 250 }
  validates :category, inclusion: {in:['Fiction', 'Non-Fiction']}

  validate :click_bait_title

  def click_bait_title
    # takes the title attribute
    # checks if the title includes 'Wont Believe', 'Secret', 'Top (some number)', 'Guess'
    # if not, then we need to display an error message 

    phrases = ["Won't Believe", "Secret","Top /\d/", "Guess"]

    if title
      is_valid = phrases.map do |phrase|
                    title.include?(phrase)
                  end.any?(true)
    end

    if !is_valid
      errors.add(:title, "This title is not click-baity enough")
    end



    # phrases = [/Won't Believe/i,/Secret/i,/Top \d/i,/Guess/i]

    # matches = phrases.none? { |phrase| phrase.match(title) }

    # matches = phrases.any? { | phrase | self.title.include?(phrase) }

    # matches = phrases.include? (title)

    # if !matches
    #   errors.add(:title, "This title is not click-baity enough")
    # end
  end
end
