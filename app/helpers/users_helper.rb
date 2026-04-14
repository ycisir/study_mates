module UsersHelper
	def avatar_for(user, variant: :thumb, size: "100x100")
	  img = user.avatar.attached? ? user.avatar.variant(variant) : "default_avatar.png"
	  image_tag url_for(img), class: "me-1", size: size
	end
end
