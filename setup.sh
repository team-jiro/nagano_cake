bundle install
rails webpacker:install
rails webpacker:compile
rails db:migrate
rails db:seed
echo 'Nagano Cake has been successfully installed !'
echo 'To start registering products, please access the following URL and log in as an administrator.'
echo '(By default, the email address is "test@mail.com" and the password is "testtest")'
echo 'https:// "domain name"/admin/sign_in'