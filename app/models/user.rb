class User < ApplicationRecord
  has_secure_password

  def full_name
    "#{first_name} #{last_name}"
  end

  def image_url_or_default
    "https://www.shareicon.net/data/512x512/2016/06/30/788946_people_512x512.png"
  end
end
