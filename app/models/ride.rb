class Ride < ActiveRecord::Base
  belongs_to :user
  belongs_to :attraction

  def ticket_message
    " You do not have enough tickets to ride the #{attraction.name}."
  end

  def height_message
    " You are not tall enough to ride the #{attraction.name}."
  end

  def requirements_not_met
    if (user.height < attraction.min_height) && (user.tickets < attraction.tickets)
      "Sorry." + ticket_message + height_message
    elsif user.height < attraction.min_height
      "Sorry." + height_message
    elsif user.tickets < attraction.tickets
      "Sorry." + ticket_message
    else
      false
    end
  end

  def take_ride
    if response = requirements_not_met
      response
    else
      self.user.tickets = user.tickets - attraction.tickets
      self.user.nausea = user.nausea + attraction.nausea_rating
      self.user.happiness = user.happiness + attraction.happiness_rating
      user.save
      "Thanks for riding the #{attraction.name}!"
    end
  end

end
