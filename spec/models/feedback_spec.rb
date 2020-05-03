require 'rails_helper'

RSpec.describe Feedback, type: :model do
  #pending "add some examples to (or delete) #{__FILE__}"
  subject {
    described_class.new(name: "abc",
                        email: "abc@email.com",
                        comments: "some comments")
  }
  it 'is not valid without a name' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without email' do
    subject.email = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without comments' do
    subject.comments = nil
    expect(subject).to_not be_valid
  end

end
