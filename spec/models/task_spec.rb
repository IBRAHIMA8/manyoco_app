require 'rails_helper'

RSpec.describe Task, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
  describe 'Task model function', type: :model do
    describe 'Validation test' do
      context "If the task Title is empty" do
        it "It's hard to Validation" do
          task = Task.new(title: '', content: 'Failure test', deadline: DateTime.now, status: 'started', priority: 'low')
          expect(task).not_to be_valid
        end
      end
      context 'If the task Title and details are described' do
        it 'Validation passes' do
          task = Task.new(title: 'Title3', content: 'COCOCOCOCOS', deadline: DateTime.now, status: 'started', priority: 'low')
          expect(task).to be_valid # Write content here
        end
      end
      context "If the task details are empty" do
            it 'Validation is caught' do
              task = Task.new(title: 'Title3', content: '', deadline: DateTime.now, status: 'started', priority: 'low')
              expect(task).not_to be_valid # Write content here
            end
          end
    end
  end
end
