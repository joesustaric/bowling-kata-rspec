require 'spec_helper'
require 'ten_pin/my_class'

describe TenPin::MyClass do
  describe '#say_hello' do
    it 'says Hello' do
      expect(subject.say_hello).to eq('Hello World')
    end
  end
end
