# frozen_string_literal: true

ActiveAdmin.register AdminUser do
  menu parent: "_Admin"

  permit_params :email, :password, :password_confirmation

  config.batch_actions = false

  controller do
    def update
      with_blocking_on_default_admin_user do
        super
      end
    end

    def destroy
      with_blocking_on_default_admin_user do
        super
      end
    end

    private

    def with_blocking_on_default_admin_user
      if resource.email == AdminUser::DEFAULT_EMAIL
        flash[:alert] = "The default admin user cannot be modified."
        redirect_back fallback_location: admin_admin_users_path
      else
        yield
      end
    end
  end

  index do
    id_column
    column :email
    column "connexion le", :current_sign_in_at
    column "nbr connexion", :sign_in_count
    column "créé le", :created_at
    actions
  end

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs do
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

end
