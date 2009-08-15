module ContactsHelper
  def display_picture_thumbnail(picture)
    if picture.exists?
      image_tag picture.url(:thumbnail), :class => 'thumbnail'
    else
      image_tag '/images/no_image.jpg', :class => 'thumbnail'
    end
  end
end
