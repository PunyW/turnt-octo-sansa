module ApplicationHelper
  def edit_and_destroy_buttons(item)
    user = current_user
    unless user.nil?
      edit = link_to('Edit', url_for([:edit, item]), class: 'button info')
      if user.admin
        del = link_to('Destroy', item, method: :delete,
          data: {confirm: 'Are you sure?'}, class: 'button alert')
      end

      raw("#{edit} #{del}")
    end
  end
end
