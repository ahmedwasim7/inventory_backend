print 'Creating Users...'

users = [
  { first_name: 'User', last_name: '-1', email: 'user-1@is.com', password: 'Pass1234$', password_confirmation: 'Pass1234$' },
  { first_name: 'User', last_name: '-2', email: 'user-2@is.com', password: 'Pass1234$', password_confirmation: 'Pass1234$' }
]

users.each { |user| User.create(user) }
