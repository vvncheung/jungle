require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validations do' do

    it 'saves successfully when name, email, password are valid' do
      user = User.create(name: 'Vivian Cheung', email: 'hi@viviancheung.ca', password: '123456', password_confirmation: '123456')
      user.save
      expect(user).to be_valid
    end

    it 'does not save when email field is blank' do
      subject.email = nil
      subject.valid?
      expect(subject.errors).not_to be_empty
    end

    it 'does not save when name field is blank' do
      subject.name = nil
      subject.valid?
      expect(subject.errors).not_to be_empty
    end

    it 'does not save when password field is blank' do
      subject.password = nil
      subject.valid?
      expect(subject.errors).not_to be_empty
    end

    it 'does not save when password_confirmation field is blank' do
      subject.password_confirmation = nil
      subject.valid?
      expect(subject.errors).not_to be_empty
    end

    it 'does not save when password and password_confirmation fails to match' do
      subject.password_confirmation = '654456'
      subject.valid?
      expect(subject.errors).not_to be_empty
    end

    it 'does not save when email is not unique' do
      User.create(name: 'Vivian Cheung', email: 'hi@viviancheung.ca', password: '123456', password_confirmation: '123456', password_digest: '654321')
      subject.valid?
      expect(subject.errors).not_to be_empty
    end

    it 'does not save when password is under character limit' do
      subject.password = 'wrong'
      subject.password_confirmation = 'wrong'
      subject.valid?
      expect(subject.errors).not_to be_empty
    end

    describe '.authenticate_with_credentials' do
      it 'returns user if authenticated' do
        user = User.authenticate_with_credentials('hi@viviancheung.ca', '123456')
        expect(subject).eql? user
      end

      it 'returns nil if not authenticated' do
        user = User.authenticate_with_credentials('hi@viviancheung.ca', 'wrong')
        expect(subject).eql? nil
      end

      it 'ignores white spaces in email field and authenticates' do
        user = User.authenticate_with_credentials(' hi@viviancheung.ca ', '123456')
        expect(subject).eql? user
      end

      it 'authenticates and users if users type lower and upper case in email' do
        user = User.authenticate_with_credentials('hI@vIvIaNcHeUnG.ca', '123456')
        expect(subject).eql? user
      end

    end

  end
end