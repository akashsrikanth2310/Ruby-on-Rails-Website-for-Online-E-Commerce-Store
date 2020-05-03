require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(Name: 'John', email: 'john@example.com',password: '1234567',dob: '02-02-1900',Phone_number: '9090909090')
  end

  test 'valid user' do
    assert @user.valid?
  end

  test 'invalid without name' do
    @user.Name = nil
    refute @user.valid?, 'saved user without a name'
    assert_not_nil @user.errors[:Name], 'no validation error for name present'
  end

  test 'invalid with short name' do
    @user.Name = 'A'
    refute @user.valid?, 'saved user with a short name'
    assert_not_nil @user.errors[:Name], 'no validation error for name present'
  end

  test 'invalid with short Phone_number' do
    @user.Phone_number = '123'
    refute @user.valid?, 'saved user with a short name'
    assert_not_nil @user.errors[:Phone_number], 'no validation error for name present'
  end


  test 'invalid without email' do
    @user.email = nil
     @user.valirefuted?
    assert_not_nil @user.errors[:email]
  end

  test 'check if below 18' do
    @user.dob = '02-02-2018'
    assert @user.is_below_18?
  end

  test 'check if above 65' do
    @user.dob = '02-02-1918'
    assert @user.is_above_65?
  end
end
