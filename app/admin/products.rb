ActiveAdmin.register Product do
  remove_filter :image_attachment, :image_blob, :description
  remove_filter :order_products

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :price_cents
  permit_params :price_cents, :description, :image, :flower_colour_id, :flower_type_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:price_cents]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  form do |f|
    f.semantic_errors
    f.inputs
    f.inputs do
      f.input :image, as: :file
    end
    f.actions
  end


end
