class FacebookShare < ActiveRecord::Base
  belongs_to :facebook_account

  validates_presence_of :facebook_account

  acts_as_paranoid

  def share
    get_share_type
    case share_type
    when "text"
      response = graph.put_wall_post(content)
    when "link"
      response = graph.put_connections("me", "links", { name: name, link: link })
    end
    update_attribute("share_id", response["id"])
  end

  def delete_share
    graph.delete_object(share_id)
    self.destroy
  end

  # def get_share_url
  #   graph.get_object(share_id)
  #   binding.pry
  # end

  private

  def graph
    Koala::Facebook::API.new(facebook_account.token, ENV["FACEBOOK_APP_SECRET"])
  end

  def get_share_type
    if link.present?
      update_attribute("share_type", "link")
    else
      update_attribute("share_type", "text")
    end
  end

end
