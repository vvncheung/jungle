require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    let(:category) {Category.new(:name => 'Vegetable')}
    subject {described_class.new(:name => 'Cabbage', :price => 1500, :quantity => 15, :category => category)}  

    describe 'Validations' do

      it 'successfully saves with all four fields set and belong to a category' do
        subject.valid?
        expect(subject.errors).to be_empty
        reflection = described_class.reflect_on_association(:category)
        expect(reflection.macro).to eq :belongs_to
      end

      it 'does not save when name does not exist' do
        subject.name = nil
        subject.valid?
        expect(subject.errors).not_to be_empty
      end

      it 'does not save when price does not exist' do
        subject.price_cents = nil
        subject.valid?
        expect(subject.errors).not_to be_empty
      end

      it 'does not save when quantity doees not exist' do
        subject.quantity = nil
        subject.valid?
        expect(subject.errors).not_to be_empty
      end

      it 'does not save when does not exist' do
        subject.category = nil
        subject.valid?
        expect(subject.errors).not_to be_empty
      end
    end  
  end
end