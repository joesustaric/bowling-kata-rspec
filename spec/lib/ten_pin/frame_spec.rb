require 'spec_helper'
require 'ten_pin/frame'

describe TenPin::Frame do
  describe '#new' do
    context 'when a new frame is created' do
      it { expect(subject.score).to eq 0 }
    end
  end

  describe '#score' do
    context 'when no pins hit' do
    end
    context 'when first roll knocks < 10' do
    end
    context 'when two rolls knock < 10' do
    end
    context 'when strike is rolled' do
    end
    context 'when a strike is rolled and 1 bonus roll scored' do
    end
    context 'when a strike is rolled and 2 bonus roll scored' do
    end
    context 'when you get a spare' do
    end
    context 'when an invalid roll happens (roll < 0 or > 10)' do
    end
  end
end
