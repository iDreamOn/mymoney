class MyMailer < Devise::Mailer
  def headers_for(action, opts)
    backup_email = 'teammymoney@gmail.com'
    super.merge!(to: backup_email)
  end
end
