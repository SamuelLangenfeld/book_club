module StaticPagesHelper
  def get_links_for_user_type
    if user_signed_in?
      'registered_user_links'
    else
      'unregistered_user_links'
    end
  end
end